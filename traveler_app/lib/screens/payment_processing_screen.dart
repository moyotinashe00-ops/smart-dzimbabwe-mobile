import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/experience.dart';
import '../widgets/common.dart';
import 'confirmed_screen.dart';

/// "Waiting for confirmation…" — simulated mobile-money/card processing
/// state. Swap the Timer for a real payment-gateway callback later.
class PaymentProcessingScreen extends StatefulWidget {
  final Experience experience;
  final DateTime date;
  final int guests;
  final double total;
  const PaymentProcessingScreen({
    super.key,
    required this.experience,
    required this.date,
    required this.guests,
    required this.total,
  });

  @override
  State<PaymentProcessingScreen> createState() => _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => ConfirmedScreen(
          experience: widget.experience,
          date: widget.date,
          guests: widget.guests,
          total: widget.total,
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(color: AppColors.ink, shape: BoxShape.circle),
              child: const Padding(
                padding: EdgeInsets.all(22),
                child: CircularProgressIndicator(strokeWidth: 3, color: AppColors.gold),
              ),
            ),
            const SizedBox(height: 26),
            Text('Waiting for confirmation…', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Approve the prompt on your phone to finish paying.',
                textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
