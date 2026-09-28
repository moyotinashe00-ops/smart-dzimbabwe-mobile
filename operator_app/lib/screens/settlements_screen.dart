import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/common.dart';

class SettlementsScreen extends StatelessWidget {
  const SettlementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final total = MockData.settlements.fold<double>(0, (sum, s) => sum + s.amount);
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
              padding: const EdgeInsets.fromLTRB(20, 56, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Settlements', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.textOnDark)),
                  const SizedBox(height: 6),
                  Text('Every payout batch, tracked end to end.', style: AppTheme.onDarkTextTheme.bodyMedium),
                  const SizedBox(height: 16),
                  StatTile(value: '\$${total.toStringAsFixed(2)}', label: 'Across ${MockData.settlements.length} batches', icon: Icons.account_balance_wallet_rounded),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
            sliver: SliverList.separated(
              itemCount: MockData.settlements.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) {
                final s = MockData.settlements[i];
                final isPaid = s.status == 'Paid out';
                return SmartCard(
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(color: isPaid ? AppColors.success.withOpacity(0.14) : AppColors.gold.withOpacity(0.16), shape: BoxShape.circle),
                        child: Icon(isPaid ? Icons.check_circle_outline_rounded : Icons.schedule_rounded,
                            color: isPaid ? AppColors.success : AppColors.goldDeep, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Batch ${s.id}', style: Theme.of(context).textTheme.titleMedium),
                            Text('${DateFormat('MMM d, yyyy').format(s.date)} · ${s.bookingsCount} bookings', style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('\$${s.amount.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleMedium),
                          Text(s.status, style: TextStyle(color: isPaid ? AppColors.success : AppColors.goldDeep, fontSize: 11.5, fontWeight: FontWeight.w700, fontFamily: 'Manrope')),
                        ],
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
