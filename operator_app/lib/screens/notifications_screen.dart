import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const _items = [
    (title: 'New booking', body: 'Rutendo Chikafu booked Lake Kariba Houseboat Sunset for 4 guests.', time: '20m ago', icon: Icons.event_available_rounded, unread: true),
    (title: 'Payout sent', body: 'Batch st-2291 · \$1,284.50 has been sent to your EcoCash.', time: '2h ago', icon: Icons.account_balance_wallet_rounded, unread: true),
    (title: 'Listing approved', body: 'Community Waterhole Night Passage is now live.', time: '1d ago', icon: Icons.check_circle_outline_rounded, unread: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        title: Text('Notifications', style: Theme.of(context).textTheme.headlineSmall),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textOnLight, size: 18), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        itemCount: _items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          final n = _items[i];
          return SmartCard(
            color: n.unread ? AppColors.card : AppColors.cream,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(color: AppColors.goldSoft, shape: BoxShape.circle),
                  child: Icon(n.icon, color: AppColors.goldDeep, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(n.title, style: Theme.of(context).textTheme.titleMedium),
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
    );
  }
}
