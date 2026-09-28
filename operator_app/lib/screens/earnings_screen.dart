import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/common.dart';
import 'settlements_screen.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Text('Your earnings, clearly.', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.textOnDark)),
                  const SizedBox(height: 18),
                  Row(children: [
                    Expanded(child: StatTile(value: '\$${MockData.availableBalance.toStringAsFixed(2)}', label: 'Available', icon: Icons.account_balance_wallet_rounded, accent: AppColors.success)),
                    const SizedBox(width: 10),
                    Expanded(child: StatTile(value: '\$${MockData.pendingBalance.toStringAsFixed(2)}', label: 'Pending', icon: Icons.hourglass_top_rounded)),
                    const SizedBox(width: 10),
                    Expanded(child: StatTile(value: '\$${MockData.totalEarnings.toStringAsFixed(0)}', label: 'All-time', icon: Icons.savings_rounded)),
                  ]),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SmartCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Last 7 days', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 14),
                      MiniBarChart(values: MockData.earningsSeries, color: AppColors.ink),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Request payout',
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettlementsScreen())),
                  icon: Icons.arrow_upward_rounded,
                ),
                const SizedBox(height: 22),
                SectionHeading(title: 'Recent transactions'),
                const SizedBox(height: 12),
                ...MockData.bookings.map((b) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SmartCard(
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                  color: b.status.name == 'cancelled' ? AppColors.danger.withOpacity(0.12) : AppColors.success.withOpacity(0.12),
                                  shape: BoxShape.circle),
                              child: Icon(
                                b.status.name == 'cancelled' ? Icons.undo_rounded : Icons.arrow_downward_rounded,
                                size: 18,
                                color: b.status.name == 'cancelled' ? AppColors.danger : AppColors.success,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(b.listingTitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium),
                                  Text(b.guestName, style: Theme.of(context).textTheme.bodySmall),
                                ],
                              ),
                            ),
                            Text(
                              b.status.name == 'cancelled' ? '-\$${b.amount.toStringAsFixed(0)}' : '+\$${b.amount.toStringAsFixed(0)}',
                              style: TextStyle(
                                  color: b.status.name == 'cancelled' ? AppColors.danger : AppColors.success,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Manrope'),
                            ),
                          ],
                        ),
                      ),
                    )),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
