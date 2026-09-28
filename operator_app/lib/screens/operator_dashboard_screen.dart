import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../services/api_service.dart';
import '../widgets/common.dart';
import 'notifications_screen.dart';

class OperatorDashboardScreen extends StatefulWidget {
  const OperatorDashboardScreen({super.key});

  @override
  State<OperatorDashboardScreen> createState() => _OperatorDashboardScreenState();
}

class _OperatorDashboardScreenState extends State<OperatorDashboardScreen> {
  List<Listing> _listings = [];
  List<OperatorBooking> _recentBookings = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() => _loading = true);
    final listingsData = await ApiService.getListings();
    final bookingsData = await ApiService.getBookings();
    if (mounted) {
      setState(() {
        _listings = listingsData;
        _recentBookings = bookingsData.where((b) => b.status != BookingStatus.cancelled).take(3).toList();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalEarnings = _recentBookings.fold<double>(0, (sum, b) => sum + b.amount);

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
                          Text('Partner', style: AppTheme.onDarkTextTheme.displayMedium),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NotificationsScreen())),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: AppColors.inkPanel, shape: BoxShape.circle),
                          child: const Icon(Icons.notifications_outlined, color: AppColors.textOnDark, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(children: [
                    Expanded(child: StatTile(value: '${_listings.length}', label: 'Active listings', icon: Icons.photo_library_rounded)),
                    const SizedBox(width: 10),
                    Expanded(child: StatTile(value: '${_recentBookings.length}', label: 'Recent bookings', icon: Icons.event_available_rounded, accent: AppColors.success)),
                    const SizedBox(width: 10),
                    Expanded(child: StatTile(value: '\$${totalEarnings.toStringAsFixed(0)}', label: 'Earned so far', icon: Icons.savings_rounded)),
                  ]),
                ],
              ),
            ),
          ),
          if (_loading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator(color: AppColors.gold)),
            )
          else
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
                            Text('Revenue trend', style: Theme.of(context).textTheme.titleMedium),
                            Text('\$${totalEarnings.toStringAsFixed(0)}',
                                style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.w800, fontFamily: 'Manrope')),
                          ],
                        ),
                        const SizedBox(height: 14),
                        const MiniBarChart(values: [100, 250, 400, 300, 550, 700], color: AppColors.ink),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SectionHeading(title: 'Recent bookings'),
                  const SizedBox(height: 12),
                  if (_recentBookings.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text('No recent bookings found from backend.', style: Theme.of(context).textTheme.bodyMedium),
                    )
                  else
                    ..._recentBookings.map((b) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: SmartCard(
                            child: Row(
                              children: [
                                Container(
                                  width: 42,
                                  height: 42,
                                  decoration: const BoxDecoration(color: AppColors.goldSoft, shape: BoxShape.circle),
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
