import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class SystemStatusScreen extends StatelessWidget {
  const SystemStatusScreen({super.key});

  final List<({String name, String status, Color color})> _services = const [
    (name: 'Platform', status: 'Operational', color: AppColors.success),
    (name: 'Booking system', status: 'Operational', color: AppColors.success),
    (name: 'Payment processing', status: 'Operational', color: AppColors.success),
    (name: 'Mobile-money integrations', status: 'Degraded', color: AppColors.gold),
    (name: 'Notifications', status: 'Operational', color: AppColors.success),
    (name: 'Data services', status: 'Unavailable', color: AppColors.danger),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ink,
      appBar: AppBar(
        backgroundColor: AppColors.ink,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ADMIN PORTAL', style: TextStyle(color: AppColors.textOnDarkMuted, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2, fontFamily: 'Manrope')),
            Text('System status', style: AppTheme.onDarkTextTheme.headlineSmall),
          ],
        ),
        iconTheme: const IconThemeData(color: AppColors.textOnDark),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 32),
        children: [
          Text(
            'Current state of platform services.',
            style: AppTheme.onDarkTextTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          ..._services.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SmartCard(
                  color: AppColors.inkPanel,
                  borderColor: AppColors.lineOnDark,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(s.name, style: AppTheme.onDarkTextTheme.titleMedium),
                      Row(
                        children: [
                          Container(width: 8, height: 8, decoration: BoxDecoration(color: s.color, shape: BoxShape.circle)),
                          const SizedBox(width: 8),
                          Text(s.status, style: TextStyle(color: s.color, fontWeight: FontWeight.bold, fontSize: 12.5, fontFamily: 'Manrope')),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
