import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/common.dart';
import 'register_screen.dart';
import 'operator_home_shell.dart';
import 'admin_home_shell.dart';

/// Operator / admin sign-in. This screen — and everything reachable from
/// it — never appears in the traveler app.
class LoginScreen extends StatefulWidget {
  final UserRole role;
  const LoginScreen({super.key, required this.role});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  void _signIn() {
    setState(() => _loading = true);
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() => _loading = false);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => widget.role == UserRole.admin ? const AdminHomeShell() : const OperatorHomeShell(),
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = widget.role == UserRole.admin;
    return Scaffold(
      backgroundColor: AppColors.ink,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textOnDark, size: 18),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: 12),
              const BrandWordmark(),
              const SizedBox(height: 28),
              Text(isAdmin ? 'Administrator sign in' : 'Operator sign in', style: AppTheme.onDarkTextTheme.displayMedium),
              const SizedBox(height: 6),
              Text(
                isAdmin
                    ? 'Restricted access for Smart Dzimbabwe platform staff.'
                    : 'Manage your listings, bookings and payouts.',
                style: AppTheme.onDarkTextTheme.bodyMedium,
              ),
              const SizedBox(height: 28),
              Expanded(
                child: ListView(
                  children: [
                    _darkField(controller: _email, label: 'Email or phone', icon: Icons.alternate_email_rounded),
                    const SizedBox(height: 14),
                    _darkField(
                      controller: _password,
                      label: 'Password',
                      icon: Icons.lock_outline_rounded,
                      obscure: _obscure,
                      suffix: IconButton(
                        icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: AppColors.textOnDarkMuted, size: 19),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text('Forgot password?',
                            style: TextStyle(color: AppColors.gold, fontFamily: 'Manrope', fontWeight: FontWeight.w700, fontSize: 12.5)),
                      ),
                    ),
                  ],
                ),
              ),
              PrimaryButton(label: isAdmin ? 'Sign in' : 'Sign in to dashboard', onPressed: _signIn, loading: _loading),
              if (!isAdmin) ...[
                const SizedBox(height: 14),
                Center(
                  child: Wrap(children: [
                    Text("New operator? ", style: AppTheme.onDarkTextTheme.bodyMedium),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RegisterScreen())),
                      child: Text('Register your business',
                          style: TextStyle(color: AppColors.gold, fontFamily: 'Manrope', fontWeight: FontWeight.w700, fontSize: 13.5)),
                    ),
                  ]),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _darkField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: AppColors.textOnDark, fontFamily: 'Manrope'),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.inkPanel,
        prefixIcon: Icon(icon, color: AppColors.textOnDarkMuted, size: 19),
        suffixIcon: suffix,
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textOnDarkMuted, fontFamily: 'Manrope', fontSize: 13),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.lineOnDark)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.gold, width: 1.6)),
      ),
    );
  }
}
