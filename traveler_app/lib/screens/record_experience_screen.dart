import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/common.dart';

/// "Record your experience" — voice-note style feedback capture, no
/// account needed. Hook the mic button up to real audio capture later.
class RecordExperienceScreen extends StatefulWidget {
  const RecordExperienceScreen({super.key});

  @override
  State<RecordExperienceScreen> createState() => _RecordExperienceScreenState();
}

class _RecordExperienceScreenState extends State<RecordExperienceScreen> {
  bool _recording = false;

  @override
  Widget build(BuildContext context) {
    final trips = MockData.pastTrips();
    return Scaffold(
      backgroundColor: AppColors.ink,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const BrandWordmark(),
            const Spacer(),
            Text('Record your experience', style: AppTheme.onDarkTextTheme.headlineMedium, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text('Tell us how it went — your voice note helps other travelers and the host.',
                  textAlign: TextAlign.center, style: AppTheme.onDarkTextTheme.bodyMedium),
            ),
            const SizedBox(height: 36),
            GestureDetector(
              onTap: () => setState(() => _recording = !_recording),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: _recording ? AppColors.danger : AppColors.gold,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: (_recording ? AppColors.danger : AppColors.gold).withOpacity(0.35),
                        blurRadius: 30,
                        spreadRadius: 4),
                  ],
                ),
                child: Icon(_recording ? Icons.stop_rounded : Icons.mic_rounded, color: AppColors.ink, size: 38),
              ),
            ),
            const SizedBox(height: 14),
            Text(_recording ? 'Recording… tap to stop' : 'Tap to start recording',
                style: AppTheme.onDarkTextTheme.bodySmall),
            const Spacer(),
            if (trips.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SectionHeading(title: 'From your past trips', color: AppColors.textOnDark),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 92,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: trips.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (_, i) => SizedBox(
                    width: 92,
                    child: PhotoBlock(photo: trips[i].experience.photo, height: 92, radius: BorderRadius.circular(16)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 26),
              child: PrimaryButton(label: 'Submit experience', onPressed: () {}, expand: true),
            ),
          ],
        ),
      ),
    );
  }
}
