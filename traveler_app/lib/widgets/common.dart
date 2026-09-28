import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/experience.dart';

/// Small circular "leaf mark" badge standing in for the Smart Dzimbabwe
/// logo — gold ring on ink green, matching the brand mark used across
/// every reference screen.
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
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: 'Smart ',
                style: frauncesStyle(color, FontWeight.w600, 16)),
            TextSpan(
                text: 'Dzimbabwe',
                style: frauncesStyle(AppColors.gold, FontWeight.w600, 16)),
          ]),
        ),
      ],
    );
  }
}

// Tiny helper so BrandWordmark doesn't need a separate import juggle.
TextStyle frauncesStyle(Color color, FontWeight weight, double size) {
  return TextStyle(color: color, fontWeight: weight, fontSize: size, fontFamily: 'Fraunces');
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
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2.4, color: AppColors.ink),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[Icon(icon, size: 18, color: AppColors.ink), const SizedBox(width: 8)],
              Text(label,
                  style: const TextStyle(
                      color: AppColors.ink, fontWeight: FontWeight.w700, fontSize: 14.5, fontFamily: 'Manrope')),
            ],
          );

    final button = ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gold,
        disabledBackgroundColor: AppColors.gold.withValues(alpha: 0.6),
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

  const GhostButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.borderColor = AppColors.line,
    this.textColor = AppColors.textOnLight,
  });

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
        child: Text(label,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: 14, fontFamily: 'Manrope')),
      ),
    );
  }
}

class SmartCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final VoidCallback? onTap;

  const SmartCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color = AppColors.card,
    this.onTap,
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
            border: Border.all(color: AppColors.line.withValues(alpha: 0.7)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class PillTag extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const PillTag({super.key, required this.label, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? AppColors.ink : AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? AppColors.ink : AppColors.line),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.textOnDark : AppColors.textOnLightMuted,
            fontWeight: FontWeight.w700,
            fontSize: 12.5,
            fontFamily: 'Manrope',
          ),
        ),
      ),
    );
  }
}

class RatingBadge extends StatelessWidget {
  final double rating;
  final int? reviews;
  final Color color;
  const RatingBadge({super.key, required this.rating, this.reviews, this.color = AppColors.textOnLight});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star_rounded, size: 16, color: AppColors.gold),
        const SizedBox(width: 3),
        Text(rating.toStringAsFixed(1),
            style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 12.5, fontFamily: 'Manrope')),
        if (reviews != null) ...[
          const SizedBox(width: 3),
          Text('($reviews)',
              style: TextStyle(color: color.withValues(alpha: 0.6), fontSize: 12, fontFamily: 'Manrope')),
        ],
      ],
    );
  }
}

/// The image placeholder used everywhere an experience photo would sit —
/// a soft brand-colored gradient with a representative icon watermark.
class PhotoBlock extends StatelessWidget {
  final PlaceholderPhoto photo;
  final double? height;
  final BorderRadius radius;

  const PhotoBlock({
    super.key,
    required this.photo,
    this.height,
    this.radius = const BorderRadius.all(Radius.circular(18)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: photo.gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(opacity: 0.16, child: Icon(photo.icon, size: (height ?? 160) * 0.8, color: Colors.white)),
            Icon(photo.icon, size: 30, color: Colors.white.withValues(alpha: 0.85)),
          ],
        ),
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
      child: Text(label,
          style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 11, fontFamily: 'Manrope')),
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
            child: Text(action!,
                style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.w700, fontSize: 13, fontFamily: 'Manrope')),
          ),
      ],
    );
  }
}
