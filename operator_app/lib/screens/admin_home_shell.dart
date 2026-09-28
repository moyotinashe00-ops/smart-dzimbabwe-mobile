import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'admin_overview_screen.dart';
import 'bookings_management_screen.dart';
import 'listings_management_screen.dart';
import 'settlements_screen.dart';
import 'profile_screen.dart';

/// Root shell for a signed-in platform admin: Overview, Bookings (all
/// operators), Listings (all operators), Settlements, Profile.
class AdminHomeShell extends StatefulWidget {
  const AdminHomeShell({super.key});

  @override
  State<AdminHomeShell> createState() => _AdminHomeShellState();
}

class _AdminHomeShellState extends State<AdminHomeShell> {
  int _index = 0;

  final _screens = const [
    AdminOverviewScreen(),
    BookingsManagementScreen(isAdmin: true),
    ListingsManagementScreen(isAdmin: true),
    SettlementsScreen(),
    ProfileScreen(isAdmin: true),
  ];

  final _items = const [
    (icon: Icons.dashboard_outlined, active: Icons.dashboard_rounded, label: 'Overview'),
    (icon: Icons.event_note_outlined, active: Icons.event_note_rounded, label: 'Bookings'),
    (icon: Icons.photo_library_outlined, active: Icons.photo_library_rounded, label: 'Listings'),
    (icon: Icons.account_balance_wallet_outlined, active: Icons.account_balance_wallet_rounded, label: 'Settlements'),
    (icon: Icons.admin_panel_settings_outlined, active: Icons.admin_panel_settings_rounded, label: 'Admin'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.ink,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 24, offset: const Offset(0, -6))],
        ),
        padding: const EdgeInsets.only(top: 8, bottom: 12),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final active = i == _index;
              final item = _items[i];
              return GestureDetector(
                onTap: () => setState(() => _index = i),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: active ? AppColors.gold.withOpacity(0.16) : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(active ? item.active : item.icon, color: active ? AppColors.gold : AppColors.textOnDarkMuted, size: 21),
                      const SizedBox(height: 3),
                      Text(item.label,
                          style: TextStyle(
                              color: active ? AppColors.gold : AppColors.textOnDarkMuted,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Manrope')),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
