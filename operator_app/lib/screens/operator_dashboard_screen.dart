import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import '../widgets/common.dart';
import 'notifications_screen.dart';

class OperatorDashboardScreen extends StatelessWidget {
  const OperatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookings = MockData.bookings.where((b) => b.status != BookingStatus.cancelled).take(3).toList();
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
              padding: const EdgeInsets.fromLTRB(20, 56, 20, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Good morning,', style: AppTheme.onDarkTextTheme.bodyMedium),
                          Text(MockData.ownerName.split(' ').first, style: AppTheme.onDarkTextTheme.displayMedium),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NotificationsScreen())),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: AppColors.inkPanel, shape: BoxShape.circle),
                          child: const Icon(Icons.notifications_outlined, color: AppColors.textOnDark, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(children: [
                    Expanded(child: StatTile(value: '${MockData.listings.length}', label: 'Active listings', icon: Icons.photo_library_rounded)),
                    const SizedBox(width: 10),
                    Expanded(child: StatTile(value: '24', label: 'Bookings this month', icon: Icons.event_available_rounded, accent: AppColors.success)),
                    const SizedBox(width: 10),
                    Expanded(child: StatTile(value: '\$${MockData.totalEarnings.toStringAsFixed(0)}', label: 'Earned so far', icon: Icons.savings_rounded)),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Revenue, last 7 days', style: Theme.of(context).textTheme.titleMedium),
                          Text('\$${MockData.earningsSeries.reduce((a, b) => a + b).toStringAsFixed(0)}',
                              style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.w800, fontFamily: 'Manrope')),
                        ],
                      ),
                      const SizedBox(height: 14),
                      MiniBarChart(values: MockData.earningsSeries, color: AppColors.ink),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SectionHeading(title: 'Recent bookings'),
                const SizedBox(height: 12),
                ...bookings.map((b) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SmartCard(
                        child: Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(color: AppColors.goldSoft, shape: BoxShape.circle),
                              child: const Icon(Icons.person_rounded, color: AppColors.goldDeep),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(b.guestName, style: Theme.of(context).textTheme.titleMedium),
                                  Text(b.listingTitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall),
                                ],
                              ),
                            ),
                            Text('\$${b.amount.toStringAsFixed(0)}',
                                style: const TextStyle(color: AppColors.textOnLight, fontWeight: FontWeight.w800, fontFamily: 'Manrope')),
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
