import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifs = true;
  bool _emailNotifs = true;
  bool _smsAlerts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        title: Text('Settings', style: Theme.of(context).textTheme.headlineSmall),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textOnLight, size: 18), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          Text('Notifications', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 10),
          SmartCard(
            child: Column(children: [
              _switchRow('Push notifications', _pushNotifs, (v) => setState(() => _pushNotifs = v)),
              const Divider(height: 22),
              _switchRow('Email updates', _emailNotifs, (v) => setState(() => _emailNotifs = v)),
              const Divider(height: 22),
              _switchRow('SMS alerts', _smsAlerts, (v) => setState(() => _smsAlerts = v)),
            ]),
          ),
          const SizedBox(height: 22),
          Text('Payouts', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 10),
          SmartCard(
            child: Row(children: [
              const Icon(Icons.account_balance_outlined, color: AppColors.textOnLight),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('EcoCash · 077X XXX XXX', style: Theme.of(context).textTheme.titleMedium),
                    Text('Default payout method', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textOnLightMuted),
            ]),
          ),
          const SizedBox(height: 22),
          Text('Security', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 10),
          SmartCard(
            child: Column(children: [
              _linkRow(context, 'Change password'),
              const Divider(height: 22),
              _linkRow(context, 'Two-factor authentication'),
              const Divider(height: 22),
              _linkRow(context, 'Active sessions'),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _switchRow(String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      children: [
        Expanded(child: Text(label, style: const TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w600, fontSize: 14))),
        Switch(value: value, activeThumbColor: AppColors.gold, onChanged: onChanged),
      ],
    );
  }

  Widget _linkRow(BuildContext context, String label) {
    return Row(
      children: [
        Expanded(child: Text(label, style: Theme.of(context).textTheme.titleMedium)),
        const Icon(Icons.arrow_forward_ios_rounded, size: 13, color: AppColors.textOnLightMuted),
      ],
    );
  }
}
