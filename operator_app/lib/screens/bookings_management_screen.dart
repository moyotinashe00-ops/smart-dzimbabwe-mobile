import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import '../widgets/common.dart';

class BookingsManagementScreen extends StatefulWidget {
  final bool isAdmin;
  const BookingsManagementScreen({super.key, this.isAdmin = false});

  @override
  State<BookingsManagementScreen> createState() => _BookingsManagementScreenState();
}

class _BookingsManagementScreenState extends State<BookingsManagementScreen> {
  String _filter = 'All';
  final _filters = const ['All', 'Pending', 'Confirmed', 'Completed', 'Cancelled'];

  List<OperatorBooking> get _filtered {
    if (_filter == 'All') return MockData.bookings;
    return MockData.bookings.where((b) => b.status.name.toLowerCase() == _filter.toLowerCase()).toList();
  }

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
              padding: const EdgeInsets.fromLTRB(20, 56, 20, 20),
              child: Text(widget.isAdmin ? 'Booking oversight' : 'Booking management',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.textOnDark)),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 54,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                itemCount: _filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final f = _filters[i];
                  final selected = f == _filter;
                  return GestureDetector(
                    onTap: () => setState(() => _filter = f),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.ink : AppColors.card,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: selected ? AppColors.ink : AppColors.line),
                      ),
                      child: Text(f,
                          style: TextStyle(
                              color: selected ? AppColors.textOnDark : AppColors.textOnLightMuted,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.5,
                              fontFamily: 'Manrope')),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 110),
            sliver: SliverList.separated(
              itemCount: _filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) {
                final b = _filtered[i];
                final colors = switch (b.status) {
                  BookingStatus.confirmed => (AppColors.success.withOpacity(0.15), AppColors.success),
                  BookingStatus.pending => (AppColors.gold.withOpacity(0.18), AppColors.goldDeep),
                  BookingStatus.completed => (AppColors.line.withOpacity(0.5), AppColors.textOnLightMuted),
                  BookingStatus.cancelled => (AppColors.danger.withOpacity(0.14), AppColors.danger),
                };
                return SmartCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(b.listingTitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium)),
                          StatusPill(label: b.status.name[0].toUpperCase() + b.status.name.substring(1), bg: colors.$1, fg: colors.$2),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(children: [
                        const Icon(Icons.person_outline_rounded, size: 14, color: AppColors.textOnLightMuted),
                        const SizedBox(width: 4),
                        Text(b.guestName, style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(width: 14),
                        const Icon(Icons.calendar_today_outlined, size: 13, color: AppColors.textOnLightMuted),
                        const SizedBox(width: 4),
                        Text(DateFormat('MMM d').format(b.date), style: Theme.of(context).textTheme.bodyMedium),
                      ]),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Divider(height: 1)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${b.guests} guest${b.guests > 1 ? 's' : ''}', style: Theme.of(context).textTheme.bodySmall),
                          Text('\$${b.amount.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleMedium),
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
