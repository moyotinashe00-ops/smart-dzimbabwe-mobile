import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../services/api_service.dart';
import '../widgets/common.dart';
import 'settlements_screen.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  List<OperatorBooking> _transactions = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    setState(() => _loading = true);
    final data = await ApiService.getBookings();
    if (mounted) {
      setState(() {
        _transactions = data;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final available = _transactions.where((b) => b.status == BookingStatus.completed).fold<double>(0, (sum, b) => sum + b.amount);
    final pending = _transactions.where((b) => b.status == BookingStatus.pending || b.status == BookingStatus.confirmed).fold<double>(0, (sum, b) => sum + b.amount);
    final total = available + pending;

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
                    Expanded(child: StatTile(value: '\$${available.toStringAsFixed(2)}', label: 'Available', icon: Icons.account_balance_wallet_rounded, accent: AppColors.success)),
                    const SizedBox(width: 10),
                    Expanded(child: StatTile(value: '\$${pending.toStringAsFixed(2)}', label: 'Pending', icon: Icons.hourglass_top_rounded)),
                    const SizedBox(width: 10),
                    Expanded(child: StatTile(value: '\$${total.toStringAsFixed(0)}', label: 'All-time', icon: Icons.savings_rounded)),
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
                        Text('Earnings trend', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 14),
                        const MiniBarChart(values: [200, 450, 320, 600, 850, 700], color: AppColors.ink),
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
                  const SectionHeading(title: 'Recent transactions'),
                  const SizedBox(height: 12),
                  if (_transactions.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text('No transactions found from backend.', style: Theme.of(context).textTheme.bodyMedium),
                    )
                  else
                    ..._transactions.map((b) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SmartCard(
                            child: Row(
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                      color: b.status == BookingStatus.cancelled ? AppColors.danger.withValues(alpha: 0.12) : AppColors.success.withValues(alpha: 0.12),
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    b.status == BookingStatus.cancelled ? Icons.undo_rounded : Icons.arrow_downward_rounded,
                                    size: 18,
                                    color: b.status == BookingStatus.cancelled ? AppColors.danger : AppColors.success,
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
                                  b.status == BookingStatus.cancelled ? '-\$${b.amount.toStringAsFixed(0)}' : '+\$${b.amount.toStringAsFixed(0)}',
                                  style: TextStyle(
                                      color: b.status == BookingStatus.cancelled ? AppColors.danger : AppColors.success,
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
