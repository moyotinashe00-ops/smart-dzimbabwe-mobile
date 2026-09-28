import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/common.dart';
import 'login_screen.dart';

/// Business registration for a new tour operator.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _business = TextEditingController();
  final _owner = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  String _category = 'Wildlife';

  final _categories = const ['Wildlife', 'Heritage', 'Adventure', 'Culture', 'Water & Falls'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textOnLight, size: 18), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          Text('Register your business', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 6),
          Text('List experiences on Smart Dzimbabwe once your account is approved.',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 24),
          TextField(controller: _business, decoration: const InputDecoration(labelText: 'Business name', hintText: 'e.g. Zambezi Waters')),
          const SizedBox(height: 12),
          TextField(controller: _owner, decoration: const InputDecoration(labelText: 'Owner / contact name')),
          const SizedBox(height: 12),
          TextField(controller: _email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Business email')),
          const SizedBox(height: 12),
          TextField(controller: _phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Phone number')),
          const SizedBox(height: 12),
          Text('Primary category', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _categories.map((c) {
              final selected = c == _category;
              return GestureDetector(
                onTap: () => setState(() => _category = c),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.ink : AppColors.card,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: selected ? AppColors.ink : AppColors.line),
                  ),
                  child: Text(c,
                      style: TextStyle(
                          color: selected ? AppColors.textOnDark : AppColors.textOnLightMuted,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.5,
                          fontFamily: 'Manrope')),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          TextField(controller: _password, obscureText: true, decoration: const InputDecoration(labelText: 'Create password')),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Submit for review',
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: AppColors.card,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  title: Text('Application submitted', style: Theme.of(context).textTheme.headlineSmall),
                  content: Text(
                      "We'll review ${_business.text.isEmpty ? 'your business' : _business.text} and email you once you're approved to list.",
                      style: Theme.of(context).textTheme.bodyMedium),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const LoginScreen(role: UserRole.operator)));
                      },
                      child: const Text('Back to sign in', style: TextStyle(color: AppColors.goldDeep, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
