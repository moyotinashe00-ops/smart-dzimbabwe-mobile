import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'operator_dashboard_screen.dart';
import 'bookings_management_screen.dart';
import 'listings_management_screen.dart';
import 'earnings_screen.dart';
import 'profile_screen.dart';

/// Root shell for a signed-in operator: Dashboard, Bookings, Listings,
/// Earnings, Profile. Settings/Settlements live inside Profile.
class OperatorHomeShell extends StatefulWidget {
  const OperatorHomeShell({super.key});

  @override
  State<OperatorHomeShell> createState() => _OperatorHomeShellState();
}

class _OperatorHomeShellState extends State<OperatorHomeShell> {
  int _index = 0;

  final _screens = const [
    OperatorDashboardScreen(),
    BookingsManagementScreen(),
    ListingsManagementScreen(),
    EarningsScreen(),
    ProfileScreen(),
  ];

  final _items = const [
    (icon: Icons.space_dashboard_outlined, active: Icons.space_dashboard_rounded, label: 'Dashboard'),
    (icon: Icons.event_note_outlined, active: Icons.event_note_rounded, label: 'Bookings'),
    (icon: Icons.photo_library_outlined, active: Icons.photo_library_rounded, label: 'Listings'),
    (icon: Icons.payments_outlined, active: Icons.payments_rounded, label: 'Earnings'),
    (icon: Icons.person_outline_rounded, active: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: _BottomNav(index: _index, items: _items, onTap: (i) => setState(() => _index = i)),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int index;
  final List<({IconData icon, IconData active, String label})> items;
  final ValueChanged<int> onTap;
  const _BottomNav({required this.index, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.ink,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 24, offset: const Offset(0, -6))],
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (i) {
            final active = i == index;
            final item = items[i];
            return GestureDetector(
              onTap: () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: active ? AppColors.gold.withValues(alpha: 0.16) : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(active ? item.active : item.icon, color: active ? AppColors.gold : AppColors.textOnDarkMuted, size: 22),
                    const SizedBox(height: 3),
                    Text(item.label,
                        style: TextStyle(
                            color: active ? AppColors.gold : AppColors.textOnDarkMuted,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Manrope')),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
