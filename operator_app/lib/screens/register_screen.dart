import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/common.dart';
import 'login_screen.dart';

/// 2-Step Business Registration & Voice Experience Recording for operators.
/// Fully aligned with the Smart Dzimbabwe onboarding design system.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

enum _Step { step1Contact, step2VoiceRecord }
enum _RecordState { idle, recording, completed, transcribing, storefrontGenerated }

class _RegisterScreenState extends State<RegisterScreen> {
  _Step _currentStep = _Step.step1Contact;

  // Step 1 Controllers
  final _nameController = TextEditingController(text: 'Anesu Machingura');
  final _phoneController = TextEditingController(text: '+263 77 123 4567');
  final _locationController = TextEditingController(text: 'Avondale, Harare');
  final _usernameController = TextEditingController(text: 'anesu.carvings');
  final _passwordController = TextEditingController(text: '••••••••');
  final _payoutNumberController = TextEditingController(text: '+263 77 987 6543');
  String _selectedLanguage = 'English';
  String _payoutWallet = 'EcoCash';

  final List<String> _languages = const ['ChiShona', 'isiNdebele', 'English'];
  final List<String> _payoutWallets = const ['EcoCash', 'OneMoney', 'InnBucks', 'Bank Transfer'];

  // Step 2 Recording States
  _RecordState _recordState = _RecordState.idle;
  int _recordSeconds = 0;
  Timer? _timer;
  int _transcribeStep = 0;

  void _startRecording() {
    setState(() {
      _recordState = _RecordState.recording;
      _recordSeconds = 0;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() => _recordSeconds++);
    });
  }

  void _stopRecording() {
    _timer?.cancel();
    setState(() {
      _recordState = _RecordState.completed;
      if (_recordSeconds == 0) _recordSeconds = 16;
    });
  }

  void _startProcessingVoice() {
    setState(() {
      _recordState = _RecordState.transcribing;
      _transcribeStep = 0;
    });

    Timer.periodic(const Duration(milliseconds: 700), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      if (_transcribeStep < 3) {
        setState(() => _transcribeStep++);
      } else {
        t.cancel();
        setState(() => _recordState = _RecordState.storefrontGenerated);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _nameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _payoutNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ink,
      appBar: AppBar(
        backgroundColor: AppColors.ink,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textOnDark, size: 18),
          onPressed: () {
            if (_currentStep == _Step.step2VoiceRecord) {
              setState(() => _currentStep = _Step.step1Contact);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          _currentStep == _Step.step2VoiceRecord ? 'Back to account details' : '',
          style: const TextStyle(color: AppColors.textOnDarkMuted, fontSize: 13, fontFamily: 'Manrope'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Stepper Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  _stepperBadge(
                    number: '1',
                    label: 'Contact & account',
                    active: _currentStep == _Step.step1Contact,
                    completed: _currentStep == _Step.step2VoiceRecord,
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Container(height: 1, color: AppColors.lineOnDark)),
                  const SizedBox(width: 12),
                  _stepperBadge(
                    number: '2',
                    label: 'Voice description',
                    active: _currentStep == _Step.step2VoiceRecord,
                    completed: false,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                children: [
                  if (_currentStep == _Step.step1Contact) _buildStep1Contact() else _buildStep2VoiceRecord(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepperBadge({required String number, required String label, required bool active, required bool completed}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: active || completed ? AppColors.gold : AppColors.inkPanel,
            shape: BoxShape.circle,
            border: Border.all(color: active || completed ? AppColors.gold : AppColors.lineOnDark),
          ),
          child: Center(
            child: completed
                ? const Icon(Icons.check_rounded, size: 14, color: AppColors.ink)
                : Text(number, style: TextStyle(color: active ? AppColors.ink : AppColors.textOnDarkMuted, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: TextStyle(color: active || completed ? AppColors.textOnDark : AppColors.textOnDarkMuted, fontWeight: FontWeight.w600, fontSize: 12.5)),
      ],
    );
  }

  // --- STEP 1: Contact & Account Information ---
  Widget _buildStep1Contact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.16), borderRadius: BorderRadius.circular(12)),
          child: const Text('STEP 1 OF 2', style: TextStyle(color: AppColors.gold, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.8)),
        ),
        const SizedBox(height: 10),
        Text('Contact & account information', style: AppTheme.onDarkTextTheme.displayLarge),
        const SizedBox(height: 8),
        Text(
          "Set up how travellers reach you and how you'll get paid. Next, you'll simply describe your experience out loud.",
          style: AppTheme.onDarkTextTheme.bodyMedium,
        ),
        const SizedBox(height: 28),

        _darkLabel('Full name / trading name'),
        _darkTextField(_nameController, hint: 'Anesu Machingura'),
        const SizedBox(height: 16),

        _darkLabel('Phone number (WhatsApp / calls)'),
        _darkTextField(_phoneController, hint: '+263 ...', keyboardType: TextInputType.phone),
        const SizedBox(height: 16),

        _darkLabel('Town / rural district / monument area'),
        _darkTextField(_locationController, hint: 'Great Zimbabwe, Masvingo, Matobo...'),
        const SizedBox(height: 16),

        _darkLabel('Preferred language for voice & communication'),
        const SizedBox(height: 8),
        Row(
          children: _languages.map((lang) {
            final selected = lang == _selectedLanguage;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(lang),
                selected: selected,
                selectedColor: AppColors.gold,
                backgroundColor: AppColors.inkPanel,
                labelStyle: TextStyle(
                  color: selected ? AppColors.ink : AppColors.textOnDarkMuted,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Manrope',
                ),
                onSelected: (val) => setState(() => _selectedLanguage = lang),
                side: BorderSide(color: selected ? AppColors.gold : AppColors.lineOnDark),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),

        _darkLabel('Create a login username'),
        _darkTextField(_usernameController, hint: 'anesu.carvings'),
        const SizedBox(height: 16),

        _darkLabel('Create a password'),
        _darkTextField(_passwordController, obscure: true),
        const SizedBox(height: 16),

        _darkLabel('Payout wallet'),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.inkPanel,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.lineOnDark),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _payoutWallet,
              dropdownColor: AppColors.inkPanel,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textOnDarkMuted),
              style: const TextStyle(color: AppColors.textOnDark, fontFamily: 'Manrope', fontSize: 14, fontWeight: FontWeight.w600),
              items: _payoutWallets.map((w) => DropdownMenuItem(value: w, child: Text(w))).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _payoutWallet = val);
              },
            ),
          ),
        ),
        const SizedBox(height: 16),

        _darkLabel('Payout wallet number'),
        _darkTextField(_payoutNumberController, hint: '+263 ...', keyboardType: TextInputType.phone),
        const SizedBox(height: 6),
        const Text(
          'This number is private and used solely for settlement. Travellers see your separate contact number above.',
          style: TextStyle(color: AppColors.textOnDarkMuted, fontSize: 11.5, fontFamily: 'Manrope'),
        ),
        const SizedBox(height: 32),

        PrimaryButton(
          label: 'Proceed to Step 2: Voice Description ->',
          onPressed: () => setState(() => _currentStep = _Step.step2VoiceRecord),
        ),
        const SizedBox(height: 18),
        Center(
          child: Wrap(
            children: [
              Text('Already have an account? ', style: AppTheme.onDarkTextTheme.bodyMedium),
              GestureDetector(
                onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginScreen(role: UserRole.operator)),
                ),
                child: const Text('Log in', style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold, fontFamily: 'Manrope')),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- STEP 2: Record Your Experience ---
  Widget _buildStep2VoiceRecord() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.16), borderRadius: BorderRadius.circular(12)),
          child: const Text('STEP 2 OF 2', style: TextStyle(color: AppColors.gold, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.8)),
        ),
        const SizedBox(height: 10),
        Text('Record your experience', style: AppTheme.onDarkTextTheme.displayLarge),
        const SizedBox(height: 8),
        Text(
          'Tell us about your experience in your own words — what you offer, where you are, what visitors will experience, what\'s included and what it costs.',
          style: AppTheme.onDarkTextTheme.bodyMedium,
        ),
        const SizedBox(height: 18),

        // Language pills
        Row(
          children: _languages.map((lang) {
            final selected = lang == _selectedLanguage;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(lang),
                selected: selected,
                selectedColor: AppColors.gold,
                backgroundColor: AppColors.inkPanel,
                labelStyle: TextStyle(
                  color: selected ? AppColors.ink : AppColors.textOnDarkMuted,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Manrope',
                ),
                onSelected: (val) => setState(() => _selectedLanguage = lang),
                side: BorderSide(color: selected ? AppColors.gold : AppColors.lineOnDark),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 28),

        // Record State Card
        _buildRecordStateContent(),
      ],
    );
  }

  Widget _buildRecordStateContent() {
    switch (_recordState) {
      case _RecordState.idle:
        return Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: _startRecording,
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: AppColors.gold.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.gold, width: 2),
                  ),
                  child: const Center(
                    child: Icon(Icons.mic_rounded, color: AppColors.gold, size: 48),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Tap the microphone to start recording',
                style: TextStyle(color: AppColors.textOnDark, fontWeight: FontWeight.w600, fontSize: 15, fontFamily: 'Manrope'),
              ),
            ),
            const SizedBox(height: 6),
            const Center(
              child: Text(
                'Speak clearly in your chosen language about your experience details',
                style: TextStyle(color: AppColors.textOnDarkMuted, fontSize: 12.5, fontFamily: 'Manrope'),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );

      case _RecordState.recording:
        final minStr = (_recordSeconds ~/ 60).toString().padLeft(2, '0');
        final secStr = (_recordSeconds % 60).toString().padLeft(2, '0');
        return Column(
          children: [
            const SizedBox(height: 24),
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.danger.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.danger, width: 2.5),
                ),
                child: const Center(
                  child: Icon(Icons.graphic_eq_rounded, color: AppColors.danger, size: 54),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('$minStr:$secStr', style: const TextStyle(color: AppColors.textOnDark, fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Manrope')),
            const SizedBox(height: 4),
            Text('RECORDING · ${_selectedLanguage.toUpperCase()}',
                style: const TextStyle(color: AppColors.textOnDarkMuted, fontSize: 11.5, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              onPressed: _stopRecording,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.card,
                foregroundColor: AppColors.textOnLight,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
              icon: const Icon(Icons.stop_rounded, color: AppColors.danger, size: 20),
              label: const Text('Stop recording', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700, fontSize: 14)),
            ),
          ],
        );

      case _RecordState.completed:
        return Column(
          children: [
            SmartCard(
              color: AppColors.inkPanel,
              borderColor: AppColors.lineOnDark,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
                    child: const Icon(Icons.play_arrow_rounded, color: AppColors.ink, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Container(
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.ink,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: List.generate(
                          18,
                          (i) => Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              height: (i % 3 == 0) ? 18 : (i % 2 == 0) ? 12 : 8,
                              color: AppColors.gold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Text('00:16', style: TextStyle(color: AppColors.textOnDarkMuted, fontFamily: 'Manrope', fontSize: 12.5)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(() => _recordState = _RecordState.idle),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      side: const BorderSide(color: AppColors.lineOnDark),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                    ),
                    child: const Text('Re-record', style: TextStyle(color: AppColors.textOnDark, fontWeight: FontWeight.w700, fontFamily: 'Manrope')),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    label: 'Process description ->',
                    onPressed: _startProcessingVoice,
                  ),
                ),
              ],
            ),
          ],
        );

      case _RecordState.transcribing:
        return Column(
          children: [
            const SizedBox(height: 30),
            const SizedBox(
              width: 52,
              height: 52,
              child: CircularProgressIndicator(color: AppColors.gold, strokeWidth: 3),
            ),
            const SizedBox(height: 28),
            _processStepItem('Voice received', completed: _transcribeStep >= 1, active: _transcribeStep == 0),
            _processStepItem('Transcribing...', completed: _transcribeStep >= 2, active: _transcribeStep == 1),
            _processStepItem('Structuring your experience...', completed: _transcribeStep >= 3, active: _transcribeStep == 2),
            _processStepItem('Creating your storefront...', completed: _transcribeStep >= 4, active: _transcribeStep == 3),
          ],
        );

      case _RecordState.storefrontGenerated:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner top
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.gold.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Here's what we created from your story", style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.w700, fontSize: 12.5, fontFamily: 'Manrope')),
                  GestureDetector(
                    onTap: () => setState(() => _recordState = _RecordState.idle),
                    child: const Text('Record again', style: TextStyle(color: AppColors.textOnDark, fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'Manrope')),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)),
              child: const Text('STOREFRONT GENERATED · YOU\'RE IN CONTROL', style: TextStyle(color: AppColors.gold, fontSize: 10.5, fontWeight: FontWeight.bold, letterSpacing: 0.8)),
            ),
            const SizedBox(height: 8),
            Text('Review your listing', style: AppTheme.onDarkTextTheme.displayMedium),
            const SizedBox(height: 6),
            Text('We structured your story into a listing. Edit anything — nothing is published until you approve.', style: AppTheme.onDarkTextTheme.bodyMedium),
            const SizedBox(height: 20),

            // Voice summary card
            SmartCard(
              color: AppColors.inkPanel,
              borderColor: AppColors.lineOnDark,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.graphic_eq_rounded, color: AppColors.gold, size: 18),
                          SizedBox(width: 8),
                          Text('Your voice description', style: TextStyle(color: AppColors.textOnDark, fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'Manrope')),
                        ],
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.play_circle_outline_rounded, size: 16, color: AppColors.gold),
                        label: const Text('Replay audio', style: TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Manrope')),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '"I offer wood carving near Avondale. People come to my yard, we carve together and I show them how I make my pieces. After we eat sadza together. It is three hours, about fifteen dollars for each person. Children are welcome."',
                    style: TextStyle(color: AppColors.textOnDarkMuted, fontSize: 13, fontStyle: FontStyle.italic, height: 1.4, fontFamily: 'Manrope'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Preview Listing Card
            SmartCard(
              color: AppColors.card,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      height: 160,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF2C5E43), Color(0xFF163A2A)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Center(
                        child: Icon(Icons.nature_people_rounded, size: 64, color: AppColors.gold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text('Carve & Share: An Afternoon With Anesu', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _tagBadge('Art & Craft'),
                      const SizedBox(width: 8),
                      _tagBadge('Avondale, Harare'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('3 hours  ·  US\$15 / person', style: TextStyle(color: AppColors.goldDeep, fontWeight: FontWeight.w800, fontSize: 15, fontFamily: 'Manrope')),
                  const SizedBox(height: 10),
                  Text(
                    'Learn to carve in a family yard, then share a home-cooked meal...',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 14),
                  const Text('HIGHLIGHTS', style: TextStyle(color: AppColors.textOnLightMuted, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.8)),
                  const SizedBox(height: 6),
                  _checkHighlight('Hands-on carving with local wood'),
                  _checkHighlight('Take home your own piece'),
                  _checkHighlight('Home-cooked sadza & relish'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Callout Box
            SmartCard(
              color: AppColors.inkPanel,
              borderColor: AppColors.lineOnDark,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'It will be discoverable across Smart Dzimbabwe once you approve.',
                    style: TextStyle(color: AppColors.textOnDark, fontWeight: FontWeight.bold, fontSize: 13.5, fontFamily: 'Manrope'),
                  ),
                  const SizedBox(height: 10),
                  _checkOnDark('You keep 92% of every booking'),
                  _checkOnDark('Tourists pay in familiar methods'),
                  _checkOnDark('Edit anytime from your dashboard'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            PrimaryButton(
              label: 'Approve & publish',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: AppColors.card,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    title: Text('Storefront published!', style: Theme.of(context).textTheme.headlineSmall),
                    content: const Text(
                      'Your listing is now live on Smart Dzimbabwe. Sign in to your operator dashboard to manage bookings.',
                      style: TextStyle(fontFamily: 'Manrope', fontSize: 13.5),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const LoginScreen(role: UserRole.operator)),
                          );
                        },
                        child: const Text('Back to sign in', style: TextStyle(color: AppColors.goldDeep, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            GhostButton(
              label: 'Save as draft',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
    }
  }

  Widget _processStepItem(String title, {required bool completed, required bool active}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            completed ? Icons.check_circle_rounded : active ? Icons.radio_button_checked_rounded : Icons.radio_button_unchecked_rounded,
            color: completed ? AppColors.success : active ? AppColors.gold : AppColors.textOnDarkMuted,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              color: completed || active ? AppColors.textOnDark : AppColors.textOnDarkMuted,
              fontWeight: active ? FontWeight.bold : FontWeight.w500,
              fontFamily: 'Manrope',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _darkLabel(String text) {
    return Text(text, style: const TextStyle(color: AppColors.textOnDark, fontWeight: FontWeight.w600, fontSize: 13, fontFamily: 'Manrope'));
  }

  Widget _darkTextField(TextEditingController controller, {String? hint, bool obscure = false, TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.textOnDark, fontFamily: 'Manrope', fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.inkPanel,
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textOnDarkMuted, fontSize: 13, fontFamily: 'Manrope'),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.lineOnDark)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.gold, width: 1.6)),
      ),
    );
  }

  Widget _tagBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: AppColors.cream, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.line)),
      child: Text(text, style: const TextStyle(color: AppColors.textOnLightMuted, fontSize: 11.5, fontWeight: FontWeight.bold, fontFamily: 'Manrope')),
    );
  }

  Widget _checkHighlight(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          const Icon(Icons.check_rounded, size: 15, color: AppColors.goldDeep),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: AppColors.textOnLight, fontSize: 13, fontFamily: 'Manrope'))),
        ],
      ),
    );
  }

  Widget _checkOnDark(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded, size: 15, color: AppColors.gold),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: AppColors.textOnDarkMuted, fontSize: 12.5, fontFamily: 'Manrope'))),
        ],
      ),
    );
  }
}
