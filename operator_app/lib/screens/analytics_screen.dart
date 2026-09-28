import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ink,
      appBar: AppBar(
        backgroundColor: AppColors.ink,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ADMIN PORTAL', style: TextStyle(color: AppColors.textOnDarkMuted, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2, fontFamily: 'Manrope')),
            Text('Analytics', style: AppTheme.onDarkTextTheme.headlineSmall),
          ],
        ),
        iconTheme: const IconThemeData(color: AppColors.textOnDark),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 32),
        children: [
          Text(
            'Historical and current activity. Operational actions live in their management areas.',
            style: AppTheme.onDarkTextTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          // 1. Tourism Activity Card
          SmartCard(
            color: AppColors.inkPanel,
            borderColor: AppColors.lineOnDark,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tourism activity', style: TextStyle(color: AppColors.textOnDarkMuted, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.8, fontFamily: 'Manrope')),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Bookings over time', style: AppTheme.onDarkTextTheme.titleLarge),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.success.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.trending_up_rounded, size: 13, color: AppColors.success),
                          SizedBox(width: 4),
                          Text('Growing', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 11, fontFamily: 'Manrope')),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Area Chart
                SizedBox(
                  height: 120,
                  child: Stack(
                    children: [
                      // Grid lines
                      Positioned(top: 0, left: 0, right: 0, child: Container(height: 1, color: AppColors.lineOnDark.withValues(alpha: 0.4))),
                      Positioned(top: 40, left: 0, right: 0, child: Container(height: 1, color: AppColors.lineOnDark.withValues(alpha: 0.4))),
                      Positioned(top: 80, left: 0, right: 0, child: Container(height: 1, color: AppColors.lineOnDark.withValues(alpha: 0.4))),
                      // Shaded area representation
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _AreaChartPainter(
                            values: const [400, 800, 1200, 1300, 1500, 1600],
                            color: AppColors.gold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Apr', style: TextStyle(color: AppColors.textOnDarkMuted, fontSize: 11, fontFamily: 'Manrope')),
                    Text('May', style: TextStyle(color: AppColors.textOnDarkMuted, fontSize: 11, fontFamily: 'Manrope')),
                    Text('Jun', style: TextStyle(color: AppColors.textOnDarkMuted, fontSize: 11, fontFamily: 'Manrope')),
                    Text('Jul', style: TextStyle(color: AppColors.textOnDarkMuted, fontSize: 11, fontFamily: 'Manrope')),
                    Text('Aug', style: TextStyle(color: AppColors.textOnDarkMuted, fontSize: 11, fontFamily: 'Manrope')),
                    Text('Sep', style: TextStyle(color: AppColors.textOnDarkMuted, fontSize: 11, fontFamily: 'Manrope')),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 2. Geographic Activity Card
          SmartCard(
            color: AppColors.inkPanel,
            borderColor: AppColors.lineOnDark,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Geographic activity', style: TextStyle(color: AppColors.textOnDarkMuted, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.8, fontFamily: 'Manrope')),
                const SizedBox(height: 6),
                Text('Regional distribution — bookings by province', style: AppTheme.onDarkTextTheme.titleLarge),
                const SizedBox(height: 20),
                const MiniBarChart(
                  values: [1400, 1100, 850, 650, 500, 600, 750, 900],
                  color: AppColors.gold,
                  height: 110,
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _ProvinceLabel('Harare'),
                    _ProvinceLabel('Mat. North'),
                    _ProvinceLabel('Manica.'),
                    _ProvinceLabel('Masvingo'),
                    _ProvinceLabel('Mat. South'),
                    _ProvinceLabel('Midlands'),
                    _ProvinceLabel('Mash. West'),
                    _ProvinceLabel('Bulawayo'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 3. Economic Activity Card
          SmartCard(
            color: AppColors.inkPanel,
            borderColor: AppColors.lineOnDark,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Economic activity', style: TextStyle(color: AppColors.textOnDarkMuted, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.8, fontFamily: 'Manrope')),
                const SizedBox(height: 6),
                Text('Payment method distribution', style: AppTheme.onDarkTextTheme.titleLarge),
                const SizedBox(height: 20),
                Row(
                  children: [
                    // Donut Chart Graphic
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CustomPaint(
                        painter: _DonutChartPainter(
                          segments: const [
                            (percentage: 0.58, color: AppColors.gold),
                            (percentage: 0.16, color: Color(0xFFD15B28)),
                            (percentage: 0.14, color: Color(0xFF2A72B8)),
                            (percentage: 0.08, color: Color(0xFFC42B2B)),
                            (percentage: 0.04, color: Color(0xFF888888)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    // Legend List
                    Expanded(
                      child: Column(
                        children: [
                          _legendItem('EcoCash', '58%', AppColors.gold),
                          _legendItem('OneMoney', '16%', const Color(0xFFD15B28)),
                          _legendItem('Visa/MC', '14%', const Color(0xFF2A72B8)),
                          _legendItem('InnBucks', '8%', const Color(0xFFC42B2B)),
                          _legendItem('O\'Mari', '4%', const Color(0xFF888888)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendItem(String name, String percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text(name, style: const TextStyle(color: AppColors.textOnDark, fontSize: 13, fontFamily: 'Manrope')),
            ],
          ),
          Text(percentage, style: const TextStyle(color: AppColors.textOnDarkMuted, fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'Manrope')),
        ],
      ),
    );
  }
}

class _ProvinceLabel extends StatelessWidget {
  final String label;
  const _ProvinceLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(color: AppColors.textOnDarkMuted, fontSize: 8.5, fontFamily: 'Manrope'),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _AreaChartPainter extends CustomPainter {
  final List<double> values;
  final Color color;
  _AreaChartPainter({required this.values, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;
    final maxV = values.reduce((a, b) => a > b ? a : b);
    final minV = values.reduce((a, b) => a < b ? a : b);
    final range = (maxV - minV) == 0 ? 1.0 : (maxV - minV);

    final path = Path();
    final fillPath = Path();

    final stepX = size.width / (values.length - 1);

    for (int i = 0; i < values.length; i++) {
      final x = i * stepX;
      final normalized = (values[i] - minV) / range;
      final y = size.height - (normalized * (size.height - 16)) - 8;

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [color.withValues(alpha: 0.35), color.withValues(alpha: 0.02)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final strokePaint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _DonutChartPainter extends CustomPainter {
  final List<({double percentage, Color color})> segments;
  _DonutChartPainter({required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    double startAngle = -1.5708; // -90 degrees in radians

    final strokeWidth = 18.0;
    final rect = Rect.fromCircle(center: center, radius: radius - (strokeWidth / 2));

    for (final seg in segments) {
      final sweepAngle = seg.percentage * 2 * 3.14159;
      final paint = Paint()
        ..color = seg.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;

      canvas.drawArc(rect, startAngle, sweepAngle - 0.04, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
