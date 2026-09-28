import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'settings_screen.dart';
import 'settlements_screen.dart';
import 'analytics_screen.dart';
import 'national_tourism_intelligence_screen.dart';
import 'system_status_screen.dart';
import 'role_select_screen.dart';
import 'manage_operators_screen.dart';
import 'listing_approvals_screen.dart';
import 'listings_management_screen.dart';

class ProfileScreen extends StatefulWidget {
  final bool isAdmin;
  const ProfileScreen({super.key, this.isAdmin = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _businessName = 'Zambezi Waters';
  String _ownerName = 'Aaron Mashingaidze';

  void _editBusinessDialog() {
    final businessController = TextEditingController(text: _businessName);
    final ownerController = TextEditingController(text: _ownerName);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Edit business details', style: Theme.of(context).textTheme.headlineSmall),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: businessController, decoration: const InputDecoration(labelText: 'Business name')),
            const SizedBox(height: 12),
            TextField(controller: ownerController, decoration: const InputDecoration(labelText: 'Owner name')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textOnLightMuted, fontFamily: 'Manrope')),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.gold, foregroundColor: AppColors.ink),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                if (businessController.text.isNotEmpty) _businessName = businessController.text.trim();
                if (ownerController.text.isNotEmpty) _ownerName = ownerController.text.trim();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Business details updated successfully', style: TextStyle(fontFamily: 'Manrope')), backgroundColor: AppColors.success),
              );
            },
            child: const Text('Save', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _helpSupportDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Help & support', style: Theme.of(context).textTheme.headlineSmall),
        content: Text('Smart Dzimbabwe Partner Support\n\nEmail: support@smartdzimbabwe.co.zw\nPhone: +263 242 700 000\n\nAvailable Monday to Friday, 8am – 5pm CAT.',
            style: Theme.of(context).textTheme.bodyMedium),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.ink, foregroundColor: AppColors.textOnDark),
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.ink,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
            ),
            padding: const EdgeInsets.fromLTRB(20, 56, 20, 28),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.isAdmin ? 'Admin profile' : 'Business profile', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.textOnDark)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(20)),
                      child: const Text('Verified', style: TextStyle(color: AppColors.gold, fontFamily: 'Manrope', fontWeight: FontWeight.w700, fontSize: 11)),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.inkPanel,
                  child: Icon(widget.isAdmin ? Icons.admin_panel_settings_rounded : Icons.storefront_rounded, color: AppColors.gold, size: 32),
                ),
                const SizedBox(height: 12),
                Text(widget.isAdmin ? _ownerName : _businessName, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textOnDark)),
                Text(widget.isAdmin ? 'Platform administrator' : 'Operator · $_ownerName', style: AppTheme.onDarkTextTheme.bodySmall),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
            child: Column(
              children: [
                if (!widget.isAdmin) ...[
                  _tile(context, icon: Icons.edit_outlined, title: 'Edit business details', onTap: _editBusinessDialog),
                  _tile(context, icon: Icons.photo_library_outlined, title: 'My listings', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ListingsManagementScreen(isAdmin: false)))),
                  _tile(context, icon: Icons.account_balance_wallet_outlined, title: 'Settlements', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettlementsScreen()))),
                ] else ...[
                  _tile(context, icon: Icons.map_outlined, title: 'National tourism intelligence', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NationalTourismIntelligenceScreen()))),
                  _tile(context, icon: Icons.insights_outlined, title: 'Analytics', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AnalyticsScreen()))),
                  _tile(context, icon: Icons.groups_outlined, title: 'Manage operators', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ManageOperatorsScreen()))),
                  _tile(context, icon: Icons.rule_folder_outlined, title: 'Listing approvals', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ListingApprovalsScreen()))),
                  _tile(context, icon: Icons.dns_outlined, title: 'System status', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SystemStatusScreen()))),
                ],
                _tile(context, icon: Icons.settings_outlined, title: 'Settings', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsScreen()))),
                _tile(context, icon: Icons.help_outline_rounded, title: 'Help & support', onTap: _helpSupportDialog),
                const SizedBox(height: 8),
                _tile(
                  context,
                  icon: Icons.logout_rounded,
                  title: 'Sign out',
                  danger: true,
                  onTap: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const RoleSelectScreen()),
                    (route) => false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap, bool danger = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SmartCard(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, size: 20, color: danger ? AppColors.danger : AppColors.textOnLight),
            const SizedBox(width: 14),
            Expanded(
              child: Text(title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: danger ? AppColors.danger : AppColors.textOnLight)),
            ),
            if (!danger) const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textOnLightMuted),
          ],
        ),
      ),
    );
  }
}
