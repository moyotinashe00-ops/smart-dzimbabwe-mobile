import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/explore_screen.dart';
import '../screens/upcoming_trips_screen.dart';
import '../screens/record_experience_screen.dart';
import '../screens/notifications_screen.dart';

/// Root shell for the traveler app. No account tab, no sign-in anywhere —
/// the app opens directly here. Four tabs: Explore, Trips, Record, Alerts.
class NavShell extends StatefulWidget {
  const NavShell({super.key});

  @override
  State<NavShell> createState() => _NavShellState();
}

class _NavShellState extends State<NavShell> {
  int _index = 0;

  final _screens = const [
    ExploreScreen(),
    UpcomingTripsScreen(),
    RecordExperienceScreen(),
    NotificationsScreen(),
  ];

  final _items = const [
    (icon: Icons.explore_outlined, activeIcon: Icons.explore_rounded, label: 'Explore'),
    (icon: Icons.confirmation_num_outlined, activeIcon: Icons.confirmation_num_rounded, label: 'Trips'),
    (icon: Icons.graphic_eq_rounded, activeIcon: Icons.graphic_eq_rounded, label: 'Record'),
    (icon: Icons.notifications_none_rounded, activeIcon: Icons.notifications_rounded, label: 'Alerts'),
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
        padding: const EdgeInsets.only(top: 10, bottom: 14),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: active ? AppColors.gold.withOpacity(0.16) : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(active ? item.activeIcon : item.icon,
                          color: active ? AppColors.gold : AppColors.textOnDarkMuted, size: 24),
                      const SizedBox(height: 4),
                      Text(item.label,
                          style: TextStyle(
                            color: active ? AppColors.gold : AppColors.textOnDarkMuted,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Manrope',
                          )),
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
