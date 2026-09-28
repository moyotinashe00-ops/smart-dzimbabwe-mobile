import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/common.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ink,
      appBar: AppBar(
        backgroundColor: AppColors.ink,
        elevation: 0,
        title: Text('National tourism intelligence', style: AppTheme.onDarkTextTheme.headlineSmall),
        iconTheme: const IconThemeData(color: AppColors.textOnDark),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          Row(children: [
            Expanded(child: StatTile(value: '2,340', label: 'Visits this month', icon: Icons.visibility_rounded)),
            const SizedBox(width: 10),
            Expanded(child: StatTile(value: '18.4%', label: 'Conversion rate', icon: Icons.trending_up_rounded, accent: AppColors.success)),
          ]),
          const SizedBox(height: 14),
          SmartCard(
            color: AppColors.inkPanel,
            borderColor: AppColors.lineOnDark,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Weekly visits', style: AppTheme.onDarkTextTheme.titleMedium),
                const SizedBox(height: 14),
                MiniBarChart(values: MockData.analyticsWeeklyVisits, color: AppColors.gold),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SmartCard(
            color: AppColors.inkPanel,
            borderColor: AppColors.lineOnDark,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Top regions by bookings', style: AppTheme.onDarkTextTheme.titleMedium),
                const SizedBox(height: 14),
                ..._region('Victoria Falls', 0.92),
                ..._region('Kariba', 0.74),
                ..._region('Nyanga', 0.58),
                ..._region('Matobo', 0.41),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _region(String name, double value) => [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(name, style: AppTheme.onDarkTextTheme.bodyLarge),
                Text('${(value * 100).round()}%', style: AppTheme.onDarkTextTheme.bodySmall),
              ]),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 7,
                  backgroundColor: AppColors.ink,
                  valueColor: const AlwaysStoppedAnimation(AppColors.gold),
                ),
              ),
            ],
          ),
        ),
      ];
}
