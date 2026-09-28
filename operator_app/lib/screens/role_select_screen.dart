import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/common.dart';
import 'login_screen.dart';

/// "Who are you logging in as?" — every session in this app starts here.
/// This app is exclusively for operators (businesses listing experiences)
/// and admins (Smart Dzimbabwe staff) — never for travelers.
class RoleSelectScreen extends StatelessWidget {
  const RoleSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ink,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BrandWordmark(),
              const Spacer(),
              Text('Who are you\nlogging in as?', style: AppTheme.onDarkTextTheme.displayLarge),
              const SizedBox(height: 8),
              Text('Smart Dzimbabwe Partners — for tour operators and platform admins only.',
                  style: AppTheme.onDarkTextTheme.bodyMedium),
              const SizedBox(height: 32),
              _RoleCard(
                title: 'Operator portal',
                subtitle: 'Manage your listings, bookings & earnings',
                icon: Icons.store_mall_directory_rounded,
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const LoginScreen(role: UserRole.operator))),
              ),
              const SizedBox(height: 14),
              _RoleCard(
                title: 'Platform administration',
                subtitle: 'Manage operators, platform settlements & approvals',
                icon: Icons.admin_panel_settings_rounded,
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const LoginScreen(role: UserRole.admin))),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  const _RoleCard({required this.title, required this.subtitle, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SmartCard(
      color: AppColors.inkPanel,
      borderColor: AppColors.lineOnDark,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.16), shape: BoxShape.circle),
            child: Icon(icon, color: AppColors.gold, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTheme.onDarkTextTheme.titleLarge),
                Text(subtitle, style: AppTheme.onDarkTextTheme.bodySmall),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 15, color: AppColors.textOnDarkMuted),
        ],
      ),
    );
  }
}
