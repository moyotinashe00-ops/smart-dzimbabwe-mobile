import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../models/experience.dart';
import '../widgets/common.dart';
import 'payment_method_screen.dart';

/// "Who's coming along?" — guest contact details. No account required;
/// this is the only identity information collected, per-booking.
class ReserveExperienceScreen extends StatefulWidget {
  final Experience experience;
  final DateTime date;
  final int guests;
  const ReserveExperienceScreen({super.key, required this.experience, required this.date, required this.guests});

  @override
  State<ReserveExperienceScreen> createState() => _ReserveExperienceScreenState();
}

class _ReserveExperienceScreenState extends State<ReserveExperienceScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final total = widget.experience.pricePerPerson * widget.guests;
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        title: Text("Who's coming along?", style: Theme.of(context).textTheme.headlineSmall),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textOnLight, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              children: [
                SmartCard(
                  color: AppColors.ink,
                  child: Row(
                    children: [
                      SizedBox(width: 54, height: 54, child: PhotoBlock(photo: widget.experience.photo, height: 54)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.experience.title,
                                maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTheme.onDarkTextTheme.titleMedium),
                            const SizedBox(height: 4),
                            Text('${DateFormat('EEE, MMM d').format(widget.date)} · ${widget.guests} guest${widget.guests > 1 ? 's' : ''}',
                                style: AppTheme.onDarkTextTheme.bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                Text('Lead guest details', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 4),
                Text('Used only for your booking confirmation and reminders.',
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 16),
                TextField(controller: _name, decoration: const InputDecoration(labelText: 'Full name', hintText: 'e.g. Tinashe Moyo')),
                const SizedBox(height: 12),
                TextField(controller: _email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email', hintText: 'you@email.com')),
                const SizedBox(height: 12),
                TextField(controller: _phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Phone number', hintText: '+263 7X XXX XXXX')),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            decoration: BoxDecoration(
              color: AppColors.card,
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 16, offset: const Offset(0, -4))],
            ),
            child: Row(children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total', style: Theme.of(context).textTheme.bodySmall),
                    Text('\$${total.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: PrimaryButton(
                  label: 'Continue to payment',
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => PaymentMethodScreen(
                      experience: widget.experience,
                      date: widget.date,
                      guests: widget.guests,
                      guestName: _name.text.isEmpty ? 'Guest' : _name.text,
                    ),
                  )),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
