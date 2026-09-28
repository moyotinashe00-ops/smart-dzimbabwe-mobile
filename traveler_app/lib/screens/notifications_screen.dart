import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/common.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = MockData.notifications();
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.ink,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
              ),
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
              child: Text('Notifications', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.textOnDark)),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 110),
            sliver: SliverList.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) {
                final n = items[i];
                return SmartCard(
                  color: n.unread ? AppColors.card : AppColors.cream,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(color: AppColors.goldSoft, shape: BoxShape.circle),
                        child: Icon(n.icon, color: AppColors.goldDeep, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text(n.title, style: Theme.of(context).textTheme.titleMedium)),
                                if (n.unread)
                                  Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle)),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(n.body, style: Theme.of(context).textTheme.bodyMedium),
                            const SizedBox(height: 6),
                            Text(n.time, style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
