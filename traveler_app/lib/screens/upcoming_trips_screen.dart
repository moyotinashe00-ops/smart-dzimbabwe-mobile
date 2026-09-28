import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../models/experience.dart';
import '../widgets/common.dart';
import 'receipt_screen.dart';

class UpcomingTripsScreen extends StatelessWidget {
  const UpcomingTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final upcoming = MockData.upcomingTrips();
    final past = MockData.pastTrips();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        body: NestedScrollView(
          headerSliverBuilder: (context, _) => [
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.ink,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
                ),
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                child: Text('Your trips', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.textOnDark)),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 16, 20, 6),
                decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16)),
                child: TabBar(
                  indicator: BoxDecoration(color: AppColors.ink, borderRadius: BorderRadius.circular(16)),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: AppColors.textOnDark,
                  unselectedLabelColor: AppColors.textOnLightMuted,
                  labelStyle: const TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700, fontSize: 13),
                  tabs: const [Tab(text: 'Upcoming'), Tab(text: 'Past')],
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _TripList(bookings: upcoming, emptyText: 'No upcoming trips yet — go find one you love.'),
              _TripList(bookings: past, emptyText: 'Your completed trips will show up here.'),
            ],
          ),
        ),
      ),
    );
  }
}

class _TripList extends StatelessWidget {
  final List<Booking> bookings;
  final String emptyText;
  const _TripList({required this.bookings, required this.emptyText});

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(emptyText, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 110),
      itemCount: bookings.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (_, i) {
        final b = bookings[i];
        final statusColors = switch (b.status) {
          BookingStatus.confirmed => (AppColors.success.withOpacity(0.15), AppColors.success),
          BookingStatus.pending => (AppColors.gold.withOpacity(0.18), AppColors.goldDeep),
          BookingStatus.completed => (AppColors.line.withOpacity(0.5), AppColors.textOnLightMuted),
        };
        return SmartCard(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ReceiptScreen(booking: b))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 60, height: 60, child: PhotoBlock(photo: b.experience.photo, height: 60)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(b.experience.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text(DateFormat('EEE, MMM d, yyyy').format(b.date), style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatusPill(
                    label: b.status.name[0].toUpperCase() + b.status.name.substring(1),
                    bg: statusColors.$1,
                    fg: statusColors.$2,
                  ),
                  Text('\$${b.totalPaid.toStringAsFixed(2)}',
                      style: const TextStyle(color: AppColors.textOnLight, fontWeight: FontWeight.w800, fontSize: 13, fontFamily: 'Manrope')),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
