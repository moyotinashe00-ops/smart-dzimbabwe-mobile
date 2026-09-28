import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/common.dart';

/// Create or edit a listing. Passing an existing [listing] pre-fills the
/// form for editing; omit it to create a new one.
class AddEditListingScreen extends StatefulWidget {
  final Listing? listing;
  const AddEditListingScreen({super.key, this.listing});

  @override
  State<AddEditListingScreen> createState() => _AddEditListingScreenState();
}

class _AddEditListingScreenState extends State<AddEditListingScreen> {
  late final TextEditingController _title = TextEditingController(text: widget.listing?.title ?? '');
  late final TextEditingController _location = TextEditingController(text: widget.listing?.location ?? '');
  late final TextEditingController _price = TextEditingController(text: widget.listing?.price.toStringAsFixed(0) ?? '');
  late final TextEditingController _description = TextEditingController();
  late String _category = widget.listing?.category ?? 'Wildlife';
  late bool _published = widget.listing?.status == ListingStatus.published;

  final _categories = const ['Wildlife', 'Heritage', 'Adventure', 'Culture', 'Water & Falls'];

  @override
  Widget build(BuildContext context) {
    final editing = widget.listing != null;
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        title: Text(editing ? 'Edit listing' : 'New listing', style: Theme.of(context).textTheme.headlineSmall),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textOnLight, size: 18), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.line, style: BorderStyle.solid),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate_outlined, color: AppColors.textOnLightMuted, size: 30),
                  SizedBox(height: 8),
                  Text('Add cover photo', style: TextStyle(fontFamily: 'Manrope', color: AppColors.textOnLightMuted, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          TextField(controller: _title, decoration: const InputDecoration(labelText: 'Experience title')),
          const SizedBox(height: 12),
          TextField(controller: _location, decoration: const InputDecoration(labelText: 'Location')),
          const SizedBox(height: 12),
          TextField(controller: _price, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Price per person (USD)', prefixText: '\$ ')),
          const SizedBox(height: 12),
          TextField(controller: _description, maxLines: 4, decoration: const InputDecoration(labelText: 'Description', alignLabelWithHint: true)),
          const SizedBox(height: 16),
          Text('Category', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _categories.map((c) {
              final selected = c == _category;
              return GestureDetector(
                onTap: () => setState(() => _category = c),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.ink : AppColors.card,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: selected ? AppColors.ink : AppColors.line),
                  ),
                  child: Text(c,
                      style: TextStyle(
                          color: selected ? AppColors.textOnDark : AppColors.textOnLightMuted,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.5,
                          fontFamily: 'Manrope')),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          SmartCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Publish immediately', style: Theme.of(context).textTheme.titleMedium),
                      Text('Off saves this as a draft for later.', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                Switch(value: _published, activeThumbColor: AppColors.gold, onChanged: (v) => setState(() => _published = v)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: editing ? 'Save changes' : 'Create listing',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
