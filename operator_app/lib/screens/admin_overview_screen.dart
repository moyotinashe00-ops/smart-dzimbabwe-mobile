import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/common.dart';
import 'analytics_screen.dart';
import 'listing_approvals_screen.dart';

class AdminOverviewScreen extends StatelessWidget {
  const AdminOverviewScreen({super.key});

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
              padding: const EdgeInsets.fromLTRB(20, 56, 20, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Admin overview', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.textOnDark)),
                  const SizedBox(height: 18),
                  Row(children: [
                    Expanded(child: StatTile(value: '86', label: 'Active operators', icon: Icons.storefront_rounded)),
                    const SizedBox(width: 10),
                    Expanded(child: StatTile(value: '312', label: 'Live listings', icon: Icons.photo_library_rounded)),
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(child: StatTile(value: '4', label: 'Pending approvals', icon: Icons.pending_actions_rounded, accent: AppColors.gold)),
                    const SizedBox(width: 10),
                    Expanded(child: StatTile(value: '\$38.2K', label: 'Platform GMV, month', icon: Icons.query_stats_rounded, accent: AppColors.success)),
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
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AnalyticsScreen())),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(color: AppColors.ink, shape: BoxShape.circle),
                        child: const Icon(Icons.insights_rounded, color: AppColors.gold, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('National tourism intelligence', style: Theme.of(context).textTheme.titleMedium),
                            Text('Visits, conversion & regional demand', style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textOnLightMuted),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SectionHeading(title: 'Pending approvals'),
                const SizedBox(height: 12),
                ...MockData.pendingApprovals.map((p) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SmartCard(
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(color: AppColors.goldSoft, shape: BoxShape.circle),
                              child: Icon(p.icon, color: AppColors.goldDeep, size: 19),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(p.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium),
                                  Text(p.subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton(
                              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ListingApprovalsScreen())),
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: AppColors.line),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8)),
                              child: const Text('Review', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700, fontSize: 12, color: AppColors.textOnLight)),
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
