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
    final platformFee = subtotal * 0.08;
    final total = booking.totalPaid > 0 ? booking.totalPaid : (subtotal + platformFee);
    final operatorPayout = subtotal - platformFee;

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        title: Text('Digital receipt', style: Theme.of(context).textTheme.headlineSmall),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textOnLight, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share_rounded, color: AppColors.textOnLight, size: 20),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Receipt shared successfully', style: TextStyle(fontFamily: 'Manrope')), backgroundColor: AppColors.success),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          SmartCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Smart Dzimbabwe', style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 2),
                        const Text('DIGITAL RECEIPT', style: TextStyle(color: AppColors.goldDeep, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.8)),
                      ],
                    ),
                    StatusPill(
                      label: booking.status.name[0].toUpperCase() + booking.status.name.substring(1),
                      bg: const Color(0x264C8C5B),
                      fg: AppColors.success,
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(height: 1)),
                _line(context, 'Booking reference', booking.reference),
                _line(context, 'Experience', e.title),
                _line(context, 'Operator', e.operatorName),
                _line(context, 'Guest', 'Guest traveller'),
                _line(context, 'Date', DateFormat('d MMM yyyy').format(booking.date)),
                _line(context, 'Guests', '${booking.guests}'),
                _line(context, 'Amount', 'US\$${subtotal.toStringAsFixed(2)}'),
                _line(context, 'Platform fee (8%)', 'US\$${platformFee.toStringAsFixed(2)}'),
                _line(context, 'Payment method', 'EcoCash'),
                _line(context, 'Payment reference', 'EC${booking.reference.hashCode.abs() % 900000 + 100000}'),
                const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(height: 1)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total paid', style: Theme.of(context).textTheme.titleMedium),
                    Text('US\$${total.toStringAsFixed(2)}', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.ink)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Operator receives US\$${operatorPayout.toStringAsFixed(2)} after the platform fee. Thank you for travelling with Smart Dzimbabwe.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(height: 1)),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Printing digital receipt...', style: TextStyle(fontFamily: 'Manrope')), backgroundColor: AppColors.ink),
                          );
                        },
                        icon: const Icon(Icons.print_outlined, size: 18),
                        label: const Text('Print receipt', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textOnLight,
                          side: const BorderSide(color: AppColors.line),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Receipt saved successfully to device!', style: TextStyle(fontFamily: 'Manrope')), backgroundColor: AppColors.success),
                          );
                        },
                        icon: const Icon(Icons.download_rounded, size: 18, color: Colors.white),
                        label: const Text('Save receipt', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.ink,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _line(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
          const SizedBox(width: 12),
          Text(value, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, color: AppColors.textOnLight)),
        ],
      ),
    );
  }
}
