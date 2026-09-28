import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../services/api_service.dart';
import '../widgets/common.dart';
import 'add_edit_listing_screen.dart';

class ListingsManagementScreen extends StatefulWidget {
  final bool isAdmin;
  const ListingsManagementScreen({super.key, this.isAdmin = false});

  @override
  State<ListingsManagementScreen> createState() => _ListingsManagementScreenState();
}

class _ListingsManagementScreenState extends State<ListingsManagementScreen> {
  List<Listing> _listings = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchListings();
  }

  Future<void> _fetchListings() async {
    setState(() => _loading = true);
    final data = await ApiService.getListings();
    if (mounted) {
      setState(() {
        _listings = data;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      floatingActionButton: widget.isAdmin
          ? null
          : FloatingActionButton.extended(
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.ink,
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddEditListingScreen()));
                _fetchListings();
              },
              label: const Text('New listing', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
              icon: const Icon(Icons.add_rounded),
            ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.ink,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
              ),
              padding: const EdgeInsets.fromLTRB(20, 56, 20, 20),
              child: Text(widget.isAdmin ? 'All listings' : 'Experiences & listings',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.textOnDark)),
            ),
          ),
          if (_loading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator(color: AppColors.gold)),
            )
          else if (_listings.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text('No listings found from backend.', style: Theme.of(context).textTheme.bodyMedium),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 110),
              sliver: SliverList.separated(
                itemCount: _listings.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (_, i) {
                  final l = _listings[i];
                  final statusColors = switch (l.status) {
                    ListingStatus.published => (AppColors.success.withValues(alpha: 0.15), AppColors.success),
                    ListingStatus.pending => (AppColors.gold.withValues(alpha: 0.18), AppColors.goldDeep),
                    ListingStatus.draft => (AppColors.line.withValues(alpha: 0.6), AppColors.textOnLightMuted),
                  };
                  return SmartCard(
                    onTap: widget.isAdmin ? null : () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddEditListingScreen(listing: l))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 74, height: 74, child: PhotoBlock(photo: l.photo, height: 74)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Expanded(child: Text(l.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium)),
                                StatusPill(label: l.status.name[0].toUpperCase() + l.status.name.substring(1), bg: statusColors.$1, fg: statusColors.$2),
                              ]),
                              const SizedBox(height: 4),
                              Text(l.location, style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('\$${l.price.toStringAsFixed(0)} / person', style: Theme.of(context).textTheme.bodyMedium),
                                  if (l.bookingsCount > 0)
                                    Text('${l.bookingsCount} bookings',
                                        style: const TextStyle(color: AppColors.textOnLight, fontWeight: FontWeight.w700, fontSize: 12, fontFamily: 'Manrope')),
                                ],
                              ),
                            ],
                          ),
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
