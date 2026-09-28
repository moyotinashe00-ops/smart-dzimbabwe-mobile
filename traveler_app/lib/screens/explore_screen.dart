import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/experience.dart';
import '../services/api_service.dart';
import '../widgets/common.dart';
import 'listing_detail_screen.dart';

/// The very first thing a traveler sees — no splash, no login, no
/// onboarding gate. Straight to browsable listings fetched from backend API.
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _category = 'All';
  String _query = '';
  List<Experience> _experiences = [];
  bool _loading = true;

  static const categories = ['All', 'Wildlife', 'Heritage', 'Adventure', 'Culture', 'Water & Falls'];

  @override
  void initState() {
    super.initState();
    _fetchExperiences();
  }

  Future<void> _fetchExperiences() async {
    setState(() => _loading = true);
    final data = await ApiService.getExperiences(category: _category, query: _query);
    if (mounted) {
      setState(() {
        _experiences = data;
        _loading = false;
      });
    }
  }

  void _onCategoryChanged(String cat) {
    setState(() => _category = cat);
    _fetchExperiences();
  }

  void _onQueryChanged(String q) {
    setState(() => _query = q);
    _fetchExperiences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _Header(onQuery: _onQueryChanged)),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final c = categories[i];
                  return PillTag(label: c, selected: c == _category, onTap: () => _onCategoryChanged(c));
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 18)),
          if (_loading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator(color: AppColors.gold)),
            )
          else if (_experiences.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text('No experiences found from backend API.', style: Theme.of(context).textTheme.bodyMedium),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
              sliver: SliverList.separated(
                itemCount: _experiences.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (_, i) => _ExperienceCard(experience: _experiences[i]),
              ),
            ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final ValueChanged<String> onQuery;
  const _Header({required this.onQuery});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BrandWordmark(),
              Container(
                padding: const EdgeInsets.all(9),
                decoration: const BoxDecoration(color: AppColors.inkPanel, shape: BoxShape.circle),
                child: const Icon(Icons.location_on_outlined, color: AppColors.textOnDark, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text('Find your next\nZimbabwean story.',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.textOnDark)),
          const SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.search_rounded, color: AppColors.textOnLightMuted, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: onQuery,
                    style: const TextStyle(fontFamily: 'Manrope', fontSize: 14, color: AppColors.textOnLight),
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: 'Search experiences or places',
                    ),
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  ),
                ),
                const Icon(Icons.tune_rounded, color: AppColors.gold, size: 20),
                const SizedBox(width: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final Experience experience;
  const _ExperienceCard({required this.experience});

  @override
  Widget build(BuildContext context) {
    return SmartCard(
      padding: const EdgeInsets.all(12),
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => ListingDetailScreen(experienceId: experience.id, initialExperience: experience))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 96, height: 96, child: PhotoBlock(photo: experience.photo, height: 96)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(experience.category.toUpperCase(),
                    style: const TextStyle(
                        color: AppColors.gold, fontSize: 10.5, fontWeight: FontWeight.w800, letterSpacing: 0.6)),
                const SizedBox(height: 4),
                Text(experience.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 6),
                Row(children: [
                  const Icon(Icons.place_outlined, size: 13, color: AppColors.textOnLightMuted),
                  const SizedBox(width: 3),
                  Expanded(
                    child: Text(experience.location,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                ]),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingBadge(rating: experience.rating, reviews: experience.reviewCount),
                    Text('\$${experience.pricePerPerson.toStringAsFixed(0)} / person',
                        style: const TextStyle(
                            color: AppColors.textOnLight, fontWeight: FontWeight.w800, fontSize: 12.5, fontFamily: 'Manrope')),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
