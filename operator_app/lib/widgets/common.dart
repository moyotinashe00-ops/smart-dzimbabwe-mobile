import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';

class BrandMark extends StatelessWidget {
  final double size;
  const BrandMark({super.key, this.size = 34});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: Image.asset(
        'assets/images/icon.png',
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.ink,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.gold, width: 1.4),
          ),
          child: Icon(Icons.eco_rounded, color: AppColors.gold, size: size * 0.55),
        ),
      ),
    );
  }
}

TextStyle frauncesStyle(Color color, FontWeight weight, double size) {
  return TextStyle(color: color, fontWeight: weight, fontSize: size, fontFamily: 'Fraunces');
}

class BrandWordmark extends StatelessWidget {
  final Color color;
  const BrandWordmark({super.key, this.color = AppColors.textOnDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const BrandMark(size: 28),
        const SizedBox(width: 9),
        Text.rich(TextSpan(children: [
          TextSpan(text: 'Smart ', style: frauncesStyle(color, FontWeight.w600, 16)),
          TextSpan(text: 'Dzimbabwe', style: frauncesStyle(AppColors.gold, FontWeight.w600, 16)),
        ])),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool loading;
  final bool expand;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.expand = true,
  });

  @override
  Widget build(BuildContext context) {
    final child = loading
        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.4, color: AppColors.ink))
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[Icon(icon, size: 18, color: AppColors.ink), const SizedBox(width: 8)],
              Text(label,
                  style: const TextStyle(color: AppColors.ink, fontWeight: FontWeight.w700, fontSize: 14.5, fontFamily: 'Manrope')),
            ],
          );
    final button = ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gold,
        disabledBackgroundColor: AppColors.gold.withOpacity(0.6),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
      child: child,
    );
    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}

class GhostButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color borderColor;
  final Color textColor;
  const GhostButton({super.key, required this.label, required this.onPressed, this.borderColor = AppColors.lineOnDark, this.textColor = AppColors.textOnDark});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          side: BorderSide(color: borderColor, width: 1.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
        child: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: 14, fontFamily: 'Manrope')),
      ),
    );
  }
}

class SmartCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final VoidCallback? onTap;
  final Color borderColor;

  const SmartCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color = AppColors.card,
    this.onTap,
    this.borderColor = AppColors.line,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor.withOpacity(0.7)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class PhotoBlock extends StatelessWidget {
  final PlaceholderPhoto photo;
  final double? height;
  final BorderRadius radius;
  const PhotoBlock({super.key, required this.photo, this.height, this.radius = const BorderRadius.all(Radius.circular(16))});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: photo.gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Stack(alignment: Alignment.center, children: [
          Opacity(opacity: 0.16, child: Icon(photo.icon, size: (height ?? 140) * 0.8, color: Colors.white)),
          Icon(photo.icon, size: 26, color: Colors.white.withOpacity(0.85)),
        ]),
      ),
    );
  }
}

class StatusPill extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;
  const StatusPill({super.key, required this.label, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 11, fontFamily: 'Manrope')),
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;
  final Color color;
  const SectionHeading({super.key, required this.title, this.action, this.onAction, this.color = AppColors.textOnLight});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: color)),
        if (action != null)
          GestureDetector(
            onTap: onAction,
            child: Text(action!, style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.w700, fontSize: 13, fontFamily: 'Manrope')),
          ),
      ],
    );
  }
}

/// Compact stat tile used on dashboards ("5 · Active listings", etc.)
class StatTile extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color accent;
  const StatTile({super.key, required this.value, required this.label, required this.icon, this.accent = AppColors.gold});

  @override
  Widget build(BuildContext context) {
    return SmartCard(
      color: AppColors.inkPanel,
      borderColor: AppColors.lineOnDark,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: accent.withOpacity(0.18), shape: BoxShape.circle),
            child: Icon(icon, size: 16, color: accent),
          ),
          const SizedBox(height: 10),
          Text(value, style: AppTheme.onDarkTextTheme.headlineSmall),
          Text(label, style: AppTheme.onDarkTextTheme.bodySmall),
        ],
      ),
    );
  }
}

/// Minimal in-house sparkline/bar chart so the module has no chart-lib
/// dependency beyond what's declared in pubspec (fl_chart optional).
class MiniBarChart extends StatelessWidget {
  final List<double> values;
  final Color color;
  final double height;
  const MiniBarChart({super.key, required this.values, this.color = AppColors.gold, this.height = 90});

  @override
  Widget build(BuildContext context) {
    final maxV = values.reduce((a, b) => a > b ? a : b);
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: values
            .map((v) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: height * (v / maxV).clamp(0.08, 1.0),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
