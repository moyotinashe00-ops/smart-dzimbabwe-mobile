import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../models/experience.dart';
import '../widgets/common.dart';

class ReceiptScreen extends StatelessWidget {
  final Booking booking;
  const ReceiptScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final e = booking.experience;
    final subtotal = e.pricePerPerson * booking.guests;
    final serviceFee = subtotal * 0.05;
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        title: Text('Receipt', style: Theme.of(context).textTheme.headlineSmall),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textOnLight, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [IconButton(icon: const Icon(Icons.ios_share_rounded, color: AppColors.textOnLight, size: 20), onPressed: () {})],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          SmartCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  SizedBox(width: 56, height: 56, child: PhotoBlock(photo: e.photo, height: 56)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.title, style: Theme.of(context).textTheme.titleMedium),
                        Text(e.operatorName, style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ]),
                const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(height: 1)),
                _line(context, 'Reference', booking.reference),
                _line(context, 'Date', DateFormat('EEE, MMM d, yyyy').format(booking.date)),
                _line(context, 'Guests', '${booking.guests}'),
                _line(context, 'Status', booking.status.name[0].toUpperCase() + booking.status.name.substring(1)),
                const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(height: 1)),
                _line(context, 'Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
                _line(context, 'Service fee', '\$${serviceFee.toStringAsFixed(2)}'),
                const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1)),
                _line(context, 'Total paid', '\$${booking.totalPaid.toStringAsFixed(2)}', bold: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _line(BuildContext context, String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: bold ? FontWeight.w800 : FontWeight.w600, color: AppColors.textOnLight)),
        ],
      ),
    );
  }
}
