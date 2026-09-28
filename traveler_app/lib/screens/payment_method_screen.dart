import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/experience.dart';
import '../widgets/common.dart';
import 'payment_processing_screen.dart';

enum _PayOption { ecocash, onemoney, innbucks, card }

/// "How would you like to pay?" — mobile money (EcoCash / OneMoney / Innbucks)
/// with phone number input, and card as the fallback.
class PaymentMethodScreen extends StatefulWidget {
  final Experience experience;
  final DateTime date;
  final int guests;
  final String guestName;
  const PaymentMethodScreen({
    super.key,
    required this.experience,
    required this.date,
    required this.guests,
    required this.guestName,
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  _PayOption _option = _PayOption.ecocash;
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.experience.pricePerPerson * widget.guests;
    final showPhoneInput = _option == _PayOption.ecocash || _option == _PayOption.onemoney || _option == _PayOption.innbucks;

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        title: Text('How would you like to pay?', style: Theme.of(context).textTheme.headlineSmall),
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
                Text('Mobile money & instant wallets', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 10),
                _PayTile(
                  title: 'EcoCash',
                  subtitle: 'Pay instantly via EcoCash prompt',
                  fallbackIcon: Icons.smartphone_rounded,
                  assetIconPath: 'assets/images/payicons/ecocash.png',
                  selected: _option == _PayOption.ecocash,
                  onTap: () => setState(() => _option = _PayOption.ecocash),
                ),
                const SizedBox(height: 10),
                _PayTile(
                  title: 'OneMoney',
                  subtitle: 'Pay instantly via OneMoney prompt',
                  fallbackIcon: Icons.account_balance_wallet_rounded,
                  assetIconPath: 'assets/images/payicons/onemoney.png',
                  selected: _option == _PayOption.onemoney,
                  onTap: () => setState(() => _option = _PayOption.onemoney),
                ),
                const SizedBox(height: 10),
                _PayTile(
                  title: 'Innbucks',
                  subtitle: 'Pay via Innbucks instant transfer',
                  fallbackIcon: Icons.bolt_rounded,
                  assetIconPath: 'assets/images/payicons/innbucks.png',
                  selected: _option == _PayOption.innbucks,
                  onTap: () => setState(() => _option = _PayOption.innbucks),
                ),
                const SizedBox(height: 16),
                if (showPhoneInput) ...[
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontFamily: 'Manrope'),
                    decoration: InputDecoration(
                      labelText: 'Mobile phone number',
                      hintText: 'e.g. +263 77 123 4567',
                      prefixIcon: const Icon(Icons.phone_iphone_rounded, color: AppColors.goldDeep, size: 20),
                      filled: true,
                      fillColor: AppColors.card,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.line)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.line)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.gold, width: 1.6)),
                      labelStyle: const TextStyle(fontFamily: 'Manrope', color: AppColors.textOnLightMuted),
                      hintStyle: const TextStyle(fontFamily: 'Manrope', color: AppColors.textOnLightMuted),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                Text('Card', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 10),
                _PayTile(
                  title: 'Visa / Mastercard',
                  subtitle: 'International & local cards accepted',
                  fallbackIcon: Icons.credit_card_rounded,
                  assetIconPath: 'assets/images/payicons/visa.png',
                  selected: _option == _PayOption.card,
                  onTap: () => setState(() => _option = _PayOption.card),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            decoration: BoxDecoration(
              color: AppColors.card,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, -4))],
            ),
            child: Row(children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total due', style: Theme.of(context).textTheme.bodySmall),
                    Text('\$${total.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: PrimaryButton(
                  label: 'Confirm & pay',
                  onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => PaymentProcessingScreen(
                      experience: widget.experience,
                      date: widget.date,
                      guests: widget.guests,
                      total: total,
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

class _PayTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData fallbackIcon;
  final String? assetIconPath;
  final bool selected;
  final VoidCallback onTap;
  const _PayTile({
    required this.title,
    required this.subtitle,
    required this.fallbackIcon,
    this.assetIconPath,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SmartCard(
      onTap: onTap,
      color: selected ? AppColors.ink : AppColors.card,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: selected ? AppColors.gold.withOpacity(0.18) : AppColors.cream,
              shape: BoxShape.circle,
            ),
            child: assetIconPath != null
                ? Image.asset(
                    assetIconPath!,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Icon(fallbackIcon, color: selected ? AppColors.gold : AppColors.textOnLight, size: 20),
                  )
                : Icon(fallbackIcon, color: selected ? AppColors.gold : AppColors.textOnLight, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: (selected ? AppTheme.onDarkTextTheme : Theme.of(context).textTheme).titleMedium),
                Text(subtitle, style: (selected ? AppTheme.onDarkTextTheme : Theme.of(context).textTheme).bodySmall),
              ],
            ),
          ),
          Icon(selected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
              color: selected ? AppColors.gold : AppColors.textOnLightMuted),
        ],
      ),
    );
  }
}
