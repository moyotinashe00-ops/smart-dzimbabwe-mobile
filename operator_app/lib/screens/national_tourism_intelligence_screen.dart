import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'manage_operators_screen.dart';
import 'listings_management_screen.dart';
import 'bookings_management_screen.dart';

class NationalTourismIntelligenceScreen extends StatefulWidget {
  const NationalTourismIntelligenceScreen({super.key});

  @override
  State<NationalTourismIntelligenceScreen> createState() => _NationalTourismIntelligenceScreenState();
}

class _NationalTourismIntelligenceScreenState extends State<NationalTourismIntelligenceScreen> {
  String _activeCategory = 'Operators';
  String _selectedRegion = 'Manicaland';

  final List<String> _categories = const [
    'Operators',
    'Active Storefronts',
    'Bookings',
    'Gross Processed',
    'Demand',
  ];

  final Map<String, Map<String, dynamic>> _regionDetails = const {
    'Manicaland': {
      'status': 'emerging',
      'operators': 54,
      'storefronts': 43,
      'bookings': 610,
      'gross': 'US\$14300.00',
      'demand': '+34%',
    },
    'Masvingo': {
      'status': 'high demand',
      'operators': 37,
      'storefronts': 30,
      'bookings': 420,
      'gross': 'US\$9850.00',
      'demand': '+41%',
    },
    'Matabeleland South': {
      'status': 'emerging',
      'operators': 29,
      'storefronts': 22,
      'bookings': 180,
      'gross': 'US\$4200.00',
      'demand': '+22%',
    },
    'Midlands': {
      'status': 'high demand',
      'operators': 18,
      'storefronts': 15,
      'bookings': 130,
      'gross': 'US\$3100.00',
      'demand': '+81%',
    },
    'Harare': {
      'status': 'established',
      'operators': 86,
      'storefronts': 72,
      'bookings': 1240,
      'gross': 'US\$28400.00',
      'demand': '+18%',
    },
    'Matabeleland North': {
      'status': 'established',
      'operators': 92,
      'storefronts': 85,
      'bookings': 2100,
      'gross': 'US\$48600.00',
      'demand': '+25%',
    },
    'Bulawayo': {
      'status': 'established',
      'operators': 45,
      'storefronts': 38,
      'bookings': 510,
      'gross': 'US\$11200.00',
      'demand': '+15%',
    },
    'Mashonaland West': {
      'status': 'emerging',
      'operators': 32,
      'storefronts': 26,
      'bookings': 390,
      'gross': 'US\$8900.00',
      'demand': '+29%',
    },
  };

  @override
  Widget build(BuildContext context) {
    final details = _regionDetails[_selectedRegion] ?? _regionDetails['Manicaland']!;

    return Scaffold(
      backgroundColor: AppColors.ink,
      appBar: AppBar(
        backgroundColor: AppColors.ink,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ADMIN PORTAL', style: TextStyle(color: AppColors.textOnDarkMuted, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2, fontFamily: 'Manrope')),
            Text('National tourism intelligence', style: AppTheme.onDarkTextTheme.headlineSmall),
          ],
        ),
        iconTheme: const IconThemeData(color: AppColors.textOnDark),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 32),
        children: [
          Text(
            'Where activity is happening across Zimbabwe — click through into operational records.',
            style: AppTheme.onDarkTextTheme.bodyMedium,
          ),
          const SizedBox(height: 20),

          // Filter Pills
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((cat) {
                final selected = cat == _activeCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: selected,
                    selectedColor: AppColors.gold,
                    backgroundColor: AppColors.inkPanel,
                    labelStyle: TextStyle(
                      color: selected ? AppColors.ink : AppColors.textOnDarkMuted,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      fontFamily: 'Manrope',
                    ),
                    onSelected: (val) => setState(() => _activeCategory = cat),
                    side: BorderSide(color: selected ? AppColors.gold : AppColors.lineOnDark),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),

          // Map & Selected Region Panel
          SmartCard(
            color: AppColors.inkPanel,
            borderColor: AppColors.lineOnDark,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Interactive Map View Graphic
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.inkDeep,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.lineOnDark),
                  ),
                  child: Stack(
                    children: [
                      // Map Background Outline
                      Center(
                        child: Icon(Icons.map_outlined, size: 140, color: AppColors.gold.withValues(alpha: 0.08)),
                      ),
                      // Interactive Region Nodes
                      Positioned(top: 30, left: 30, child: _mapNode('Matabeleland North')),
                      Positioned(top: 40, left: 120, child: _mapNode('Mashonaland West')),
                      Positioned(top: 30, right: 60, child: _mapNode('Harare')),
                      Positioned(top: 90, left: 100, child: _mapNode('Bulawayo')),
                      Positioned(top: 100, left: 160, child: _mapNode('Midlands')),
                      Positioned(top: 110, right: 30, child: _mapNode('Manicaland')),
                      Positioned(bottom: 30, left: 130, child: _mapNode('Matabeleland South')),
                      Positioned(bottom: 30, right: 70, child: _mapNode('Masvingo')),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // Selected Region Detail
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedRegion, style: AppTheme.onDarkTextTheme.headlineSmall),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                      child: Text(details['status'] as String, style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold, fontSize: 11, fontFamily: 'Manrope')),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                Row(
                  children: [
                    _regionStatTile('Operators', '${details['operators']}'),
                    _regionStatTile('Est. storefronts', '${details['storefronts']}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _regionStatTile('Bookings', '${details['bookings']}'),
                    _regionStatTile('Gross', '${details['gross']}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _regionStatTile('Demand signal', details['demand'] as String, accent: AppColors.success),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Demand signal reflects recent search & interest — not a forecast.',
                  style: TextStyle(color: AppColors.textOnDarkMuted, fontSize: 11, fontStyle: FontStyle.italic, fontFamily: 'Manrope'),
                ),
                const SizedBox(height: 16),

                PrimaryButton(
                  label: 'View operators ->',
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ManageOperatorsScreen())),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: GhostButton(
                        label: 'View experiences',
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ListingsManagementScreen(isAdmin: true))),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GhostButton(
                        label: 'View bookings',
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BookingsManagementScreen(isAdmin: true))),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Inclusion & Devolution Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Inclusion & devolution', style: AppTheme.onDarkTextTheme.headlineSmall),
              const SizedBox(height: 4),
              Text(
                'Underrepresented regions with demand but limited supply — surfaced for routing, not predicted.',
                style: AppTheme.onDarkTextTheme.bodyMedium,
              ),
              const SizedBox(height: 16),

              _inclusionCard('Manicaland', 54, 610, '+34%'),
              _inclusionCard('Masvingo', 37, 420, '+41%'),
              _inclusionCard('Matabeleland South', 29, 180, '+22%'),
              _inclusionCard('Midlands', 18, 130, '+81%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mapNode(String name) {
    final selected = name == _selectedRegion;
    return GestureDetector(
      onTap: () => setState(() => _selectedRegion = name),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? AppColors.gold : AppColors.inkPanel,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? AppColors.gold : AppColors.lineOnDark),
          boxShadow: selected ? [BoxShadow(color: AppColors.gold.withValues(alpha: 0.4), blurRadius: 8)] : null,
        ),
        child: Text(
          name,
          style: TextStyle(
            color: selected ? AppColors.ink : AppColors.textOnDark,
            fontWeight: FontWeight.bold,
            fontSize: 9.5,
            fontFamily: 'Manrope',
          ),
        ),
      ),
    );
  }

  Widget _regionStatTile(String label, String value, {Color accent = AppColors.textOnDark}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: AppColors.inkDeep,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lineOnDark),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: AppColors.textOnDarkMuted, fontSize: 10.5, fontFamily: 'Manrope')),
            const SizedBox(height: 2),
            Text(value, style: TextStyle(color: accent, fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Manrope')),
          ],
        ),
      ),
    );
  }

  Widget _inclusionCard(String region, int operators, int bookings, String demand) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SmartCard(
        color: AppColors.inkPanel,
        borderColor: AppColors.lineOnDark,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(region, style: AppTheme.onDarkTextTheme.titleLarge),
                  const SizedBox(height: 2),
                  Text('$operators operators  ·  $bookings bookings  ·  demand $demand', style: AppTheme.onDarkTextTheme.bodySmall),
                ],
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ManageOperatorsScreen())),
              child: const Text('Operators ->', style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold, fontSize: 12.5, fontFamily: 'Manrope')),
            ),
          ],
        ),
      ),
    );
  }
}
