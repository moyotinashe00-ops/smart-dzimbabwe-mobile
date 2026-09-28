import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/common.dart';
import 'reservation_dates_screen.dart';

class ListingDetailScreen extends StatelessWidget {
  final String experienceId;
  const ListingDetailScreen({super.key, required this.experienceId});

  @override
  Widget build(BuildContext context) {
    final e = MockData.byId(experienceId);
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 300,
                backgroundColor: AppColors.ink,
                leading: Padding(
                  padding: const EdgeInsets.all(10),
                  child: _RoundIcon(icon: Icons.arrow_back_ios_new_rounded, onTap: () => Navigator.pop(context)),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: _RoundIcon(icon: Icons.favorite_border_rounded, onTap: () {}),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: PhotoBlock(photo: e.photo, height: 300, radius: BorderRadius.zero),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  transform: Matrix4.translationValues(0, -22, 0),
                  decoration: const BoxDecoration(
                    color: AppColors.cream,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(26), topRight: Radius.circular(26)),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 26, 20, 140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.category.toUpperCase(),
                          style: const TextStyle(
                              color: AppColors.gold, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.6)),
                      const SizedBox(height: 6),
                      Text(e.title, style: Theme.of(context).textTheme.displayMedium),
                      const SizedBox(height: 10),
                      Row(children: [
                        RatingBadge(rating: e.rating, reviews: e.reviewCount),
                        const SizedBox(width: 14),
                        const Icon(Icons.place_outlined, size: 15, color: AppColors.textOnLightMuted),
                        const SizedBox(width: 3),
                        Expanded(child: Text(e.location, style: Theme.of(context).textTheme.bodyMedium)),
                      ]),
                      const SizedBox(height: 20),
                      SmartCard(
                        color: AppColors.ink,
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.inkPanel,
                                child: const Icon(Icons.person_rounded, color: AppColors.gold)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Hosted by', style: AppTheme.onDarkTextTheme.bodySmall),
                                  Text(e.operatorName,
                                      style: AppTheme.onDarkTextTheme.titleMedium?.copyWith(fontSize: 15)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                  color: AppColors.inkPanel, borderRadius: BorderRadius.circular(20)),
                              child: Row(children: [
                                const Icon(Icons.schedule_rounded, size: 14, color: AppColors.gold),
                                const SizedBox(width: 4),
                                Text('${e.durationHours}h', style: AppTheme.onDarkTextTheme.bodySmall),
                              ]),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text('About this experience', style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 10),
                      Text(e.description, style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: 24),
                      Text("What's included", style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 10),
                      ...e.highlights.map((h) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(children: [
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(color: AppColors.goldSoft, shape: BoxShape.circle),
                                child: const Icon(Icons.check_rounded, size: 14, color: AppColors.goldDeep),
                              ),
                              const SizedBox(width: 10),
                              Expanded(child: Text(h, style: Theme.of(context).textTheme.bodyLarge)),
                            ]),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              decoration: BoxDecoration(
                color: AppColors.cream,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -6))],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From', style: Theme.of(context).textTheme.bodySmall),
                        Text('\$${e.pricePerPerson.toStringAsFixed(0)} / person',
                            style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: PrimaryButton(
                      label: 'Reserve experience',
                      onPressed: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => ReservationDatesScreen(experience: e))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _RoundIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.35), shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 17),
      ),
    );
  }
}
