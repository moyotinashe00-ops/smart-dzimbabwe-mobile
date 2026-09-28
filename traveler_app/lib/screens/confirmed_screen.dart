import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../models/experience.dart';
import '../widgets/common.dart';
import '../widgets/nav_shell.dart';

/// "You're all set" — booking confirmation, receipt summary in place.
class ConfirmedScreen extends StatelessWidget {
  final Experience experience;
  final DateTime date;
  final int guests;
  final double total;
  const ConfirmedScreen({
    super.key,
    required this.experience,
    required this.date,
    required this.guests,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final ref = 'SD-${(experience.id.hashCode.abs() % 90000 + 10000)}-${experience.location.substring(0, 3).toUpperCase()}';
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 78,
                height: 78,
                decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.15), shape: BoxShape.circle),
                child: const Icon(Icons.check_rounded, color: AppColors.success, size: 40),
              ),
              const SizedBox(height: 20),
              Text("You're all set.", style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 6),
              Text('A confirmation has been sent to you.',
                  style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
              const SizedBox(height: 26),
              SmartCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      SizedBox(width: 50, height: 50, child: PhotoBlock(photo: experience.photo, height: 50)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(experience.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium),
                            Text(experience.location, style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ]),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: Divider(height: 1)),
                    _row(context, 'Date', DateFormat('EEEE, MMM d, yyyy').format(date)),
                    const SizedBox(height: 8),
                    _row(context, 'Guests', '$guests'),
                    const SizedBox(height: 8),
                    _row(context, 'Reference', ref),
                    const SizedBox(height: 8),
                    _row(context, 'Total paid', '\$${total.toStringAsFixed(2)}', bold: true),
                  ],
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Done',
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const NavShell()),
                  (route) => false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: bold ? FontWeight.w800 : FontWeight.w600, color: AppColors.textOnLight)),
      ],
    );
  }
}
