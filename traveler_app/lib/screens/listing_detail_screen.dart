import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/experience.dart';
import '../services/api_service.dart';
import '../widgets/common.dart';
import 'reservation_dates_screen.dart';

class ListingDetailScreen extends StatefulWidget {
  final String experienceId;
  final Experience? initialExperience;
  const ListingDetailScreen({super.key, required this.experienceId, this.initialExperience});

  @override
  State<ListingDetailScreen> createState() => _ListingDetailScreenState();
}

class _ListingDetailScreenState extends State<ListingDetailScreen> {
  Experience? _experience;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialExperience != null) {
      _experience = widget.initialExperience;
    } else {
      _fetchExperience();
    }
  }

  Future<void> _fetchExperience() async {
    setState(() => _loading = true);
    final data = await ApiService.getExperienceById(widget.experienceId);
    if (mounted) {
      setState(() {
        _experience = data;
        _loading = false;
      });
    }
  }

  void _showMapDialog(BuildContext context, Experience e) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.map_rounded, color: AppColors.goldDeep),
            const SizedBox(width: 10),
            Expanded(child: Text('Location & Map', style: Theme.of(context).textTheme.headlineSmall)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.ink,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.terrain_rounded, size: 64, color: AppColors.lineOnDark),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.inkPanel, borderRadius: BorderRadius.circular(10)),
                      child: Text(e.location, style: AppTheme.onDarkTextTheme.bodySmall),
                    ),
                  ),
                  const Center(
                    child: Icon(Icons.location_pin, color: AppColors.gold, size: 40),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Text(e.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text('Destination region: ${e.location}', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            const Text('GPS Coordinates: -17.8252° S, 31.0335° E', style: TextStyle(color: AppColors.textOnLightMuted, fontSize: 12, fontFamily: 'Manrope')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close', style: TextStyle(color: AppColors.textOnLightMuted, fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.ink, foregroundColor: AppColors.textOnDark),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening GPS Navigation & Directions...', style: TextStyle(fontFamily: 'Manrope')), backgroundColor: AppColors.success),
              );
            },
            icon: const Icon(Icons.directions_rounded, size: 16, color: AppColors.gold),
            label: const Text('Get directions', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: AppColors.cream,
        body: Center(child: CircularProgressIndicator(color: AppColors.gold)),
      );
    }

    final e = _experience;
    if (e == null) {
      return Scaffold(
        backgroundColor: AppColors.cream,
        appBar: AppBar(backgroundColor: AppColors.ink, elevation: 0),
        body: const Center(child: Text('Experience details not found.')),
      );
    }

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
                        OutlinedButton.icon(
                          onPressed: () => _showMapDialog(context, e),
                          icon: const Icon(Icons.map_rounded, size: 15, color: AppColors.goldDeep),
                          label: const Text('Map', style: TextStyle(fontFamily: 'Manrope', color: AppColors.textOnLight, fontSize: 12, fontWeight: FontWeight.w700)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.line),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 20),
                      SmartCard(
                        color: AppColors.ink,
                        child: Row(
                          children: [
                            const CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.inkPanel,
                                child: Icon(Icons.person_rounded, color: AppColors.gold)),
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
                                decoration: const BoxDecoration(color: AppColors.goldSoft, shape: BoxShape.circle),
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
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 20, offset: const Offset(0, -6))],
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
        decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.35), shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 17),
      ),
    );
  }
}
