import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../services/api_service.dart';
import '../widgets/common.dart';

class ListingApprovalsScreen extends StatefulWidget {
  const ListingApprovalsScreen({super.key});

  @override
  State<ListingApprovalsScreen> createState() => _ListingApprovalsScreenState();
}

class _ListingApprovalsScreenState extends State<ListingApprovalsScreen> {
  List<Listing> _pendingListings = [];
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
        _pendingListings = data.where((l) => l.status == ListingStatus.pending).toList();
        _loading = false;
      });
    }
  }

  Future<void> _approveListing(Listing listing) async {
    final updated = Listing(
      id: listing.id,
      title: listing.title,
      location: listing.location,
      category: listing.category,
      price: listing.price,
      status: ListingStatus.published,
      bookingsCount: listing.bookingsCount,
      rating: listing.rating,
      photo: listing.photo,
    );
    await ApiService.updateListing(updated);
    setState(() {
      _pendingListings.removeWhere((l) => l.id == listing.id);
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Approved "${listing.title}" — now published live', style: const TextStyle(fontFamily: 'Manrope')),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  Future<void> _rejectListing(Listing listing) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Reject listing?', style: Theme.of(context).textTheme.headlineSmall),
        content: Text('Are you sure you want to reject and remove "${listing.title}"?', style: Theme.of(context).textTheme.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textOnLightMuted, fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger, foregroundColor: Colors.white),
            onPressed: () async {
              Navigator.pop(ctx);
              await ApiService.deleteListing(listing.id);
              setState(() {
                _pendingListings.removeWhere((l) => l.id == listing.id);
              });
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Rejected and removed "${listing.title}"', style: const TextStyle(fontFamily: 'Manrope')),
                    backgroundColor: AppColors.danger,
                  ),
                );
              }
            },
            child: const Text('Reject', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.ink,
        foregroundColor: AppColors.textOnDark,
        title: const Text('Listing approvals', style: TextStyle(fontFamily: 'Fraunces', fontWeight: FontWeight.w600)),
        elevation: 0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: AppColors.gold))
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              children: [
                Text('${_pendingListings.length} listings awaiting review & approval', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 16),
                if (_pendingListings.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          const Icon(Icons.check_circle_outline_rounded, size: 48, color: AppColors.success),
                          const SizedBox(height: 12),
                          Text('All pending listings have been reviewed!', style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ),
                  ),
                ..._pendingListings.map((l) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: SmartCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 64, height: 64, child: PhotoBlock(photo: l.photo, height: 64)),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(l.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium),
                                      const SizedBox(height: 3),
                                      Text(l.location, style: Theme.of(context).textTheme.bodySmall),
                                      const SizedBox(height: 3),
                                      Text('\$${l.price.toStringAsFixed(0)} / person · ${l.category}', style: const TextStyle(color: AppColors.textOnLightMuted, fontSize: 12, fontFamily: 'Manrope')),
                                    ],
                                  ),
                                ),
                                const StatusPill(label: 'Pending', bg: AppColors.goldSoft, fg: AppColors.goldDeep),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Divider(height: 1)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () => _rejectListing(l),
                                  icon: const Icon(Icons.close_rounded, size: 16),
                                  label: const Text('Reject', style: TextStyle(fontFamily: 'Manrope', fontSize: 12, fontWeight: FontWeight.w700)),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColors.danger,
                                    side: const BorderSide(color: AppColors.danger),
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton.icon(
                                  onPressed: () => _approveListing(l),
                                  icon: const Icon(Icons.check_rounded, size: 16),
                                  label: const Text('Approve & Publish', style: TextStyle(fontFamily: 'Manrope', fontSize: 12, fontWeight: FontWeight.w700)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.success,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                    elevation: 0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
    );
  }
}
