import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import '../widgets/common.dart';

class ManageOperatorsScreen extends StatefulWidget {
  const ManageOperatorsScreen({super.key});

  @override
  State<ManageOperatorsScreen> createState() => _ManageOperatorsScreenState();
}

class _ManageOperatorsScreenState extends State<ManageOperatorsScreen> {
  void _togglePause(PlatformOperator op) {
    setState(() {
      op.isPaused = !op.isPaused;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(op.isPaused ? 'Paused ${op.businessName}' : 'Resumed ${op.businessName}', style: const TextStyle(fontFamily: 'Manrope')),
        backgroundColor: AppColors.ink,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _deleteOperator(PlatformOperator op) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Remove operator?', style: Theme.of(context).textTheme.headlineSmall),
        content: Text('Are you sure you want to remove ${op.businessName} (${op.ownerName}) from the platform? This will deactivate all their listings.',
            style: Theme.of(context).textTheme.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textOnLightMuted, fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger, foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                MockData.operators.removeWhere((o) => o.id == op.id);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Removed ${op.businessName} from platform', style: const TextStyle(fontFamily: 'Manrope')),
                  backgroundColor: AppColors.danger,
                ),
              );
            },
            child: const Text('Remove', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _addOperatorDialog() {
    final businessController = TextEditingController();
    final ownerController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Add new operator', style: Theme.of(context).textTheme.headlineSmall),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: businessController,
                decoration: const InputDecoration(labelText: 'Business name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: ownerController,
                decoration: const InputDecoration(labelText: 'Owner name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email address'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textOnLightMuted, fontFamily: 'Manrope')),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.gold, foregroundColor: AppColors.ink),
            onPressed: () {
              if (businessController.text.trim().isEmpty) return;
              Navigator.pop(ctx);
              setState(() {
                MockData.operators.add(PlatformOperator(
                  id: 'op-${DateTime.now().millisecondsSinceEpoch}',
                  businessName: businessController.text.trim(),
                  ownerName: ownerController.text.isEmpty ? 'Partner' : ownerController.text.trim(),
                  email: emailController.text.isEmpty ? 'partner@smartdzimbabwe.co.zw' : emailController.text.trim(),
                  listingsCount: 1,
                ));
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Operator added successfully', style: TextStyle(fontFamily: 'Manrope')), backgroundColor: AppColors.success),
              );
            },
            child: const Text('Add operator', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
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
        title: const Text('Manage operators', style: TextStyle(fontFamily: 'Fraunces', fontWeight: FontWeight.w600)),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.ink,
        onPressed: _addOperatorDialog,
        label: const Text('Add operator', style: TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w700)),
        icon: const Icon(Icons.add_rounded),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        children: [
          Text('${MockData.operators.length} registered partners on platform', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 16),
          if (MockData.operators.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Text('No operators found.', style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
          ...MockData.operators.map((op) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: SmartCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(op.businessName, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleLarge),
                          ),
                          StatusPill(
                            label: op.isPaused ? 'Paused' : 'Active',
                            bg: op.isPaused ? AppColors.gold.withOpacity(0.18) : AppColors.success.withOpacity(0.15),
                            fg: op.isPaused ? AppColors.goldDeep : AppColors.success,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text('Owner: ${op.ownerName} · ${op.email}', style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 6),
                      Text('${op.listingsCount} active listings', style: const TextStyle(color: AppColors.textOnLightMuted, fontSize: 12, fontFamily: 'Manrope')),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Divider(height: 1)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () => _togglePause(op),
                            icon: Icon(op.isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded, size: 16),
                            label: Text(op.isPaused ? 'Resume' : 'Pause', style: const TextStyle(fontFamily: 'Manrope', fontSize: 12, fontWeight: FontWeight.w700)),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: op.isPaused ? AppColors.success : AppColors.goldDeep,
                              side: BorderSide(color: op.isPaused ? AppColors.success : AppColors.gold),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                          ),
                          const SizedBox(width: 10),
                          OutlinedButton.icon(
                            onPressed: () => _deleteOperator(op),
                            icon: const Icon(Icons.delete_outline_rounded, size: 16),
                            label: const Text('Remove', style: TextStyle(fontFamily: 'Manrope', fontSize: 12, fontWeight: FontWeight.w700)),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.danger,
                              side: const BorderSide(color: AppColors.danger),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
