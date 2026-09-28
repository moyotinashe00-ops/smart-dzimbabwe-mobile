import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../models/experience.dart';
import '../widgets/common.dart';
import 'reserve_experience_screen.dart';

/// "When and how many?" — date + guest count picker.
class ReservationDatesScreen extends StatefulWidget {
  final Experience experience;
  const ReservationDatesScreen({super.key, required this.experience});

  @override
  State<ReservationDatesScreen> createState() => _ReservationDatesScreenState();
}

class _ReservationDatesScreenState extends State<ReservationDatesScreen> {
  DateTime _selected = DateTime.now().add(const Duration(days: 7));
  int _guests = 2;

  List<DateTime> get _monthDays {
    final first = DateTime(_selected.year, _selected.month, 1);
    final daysInMonth = DateTime(_selected.year, _selected.month + 1, 0).day;
    return List.generate(daysInMonth, (i) => DateTime(first.year, first.month, i + 1));
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.experience.pricePerPerson * _guests;
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: _AppBarLight(title: 'When and how many?'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              children: [
                Text(widget.experience.title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(widget.experience.location, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 20),
                SmartCard(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('MMMM yyyy').format(_selected),
                              style: Theme.of(context).textTheme.titleMedium),
                          Row(children: [
                            _navChip(Icons.chevron_left_rounded,
                                () => setState(() => _selected = DateTime(_selected.year, _selected.month - 1, 1))),
                            const SizedBox(width: 6),
                            _navChip(Icons.chevron_right_rounded,
                                () => setState(() => _selected = DateTime(_selected.year, _selected.month + 1, 1))),
                          ]),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _monthDays.map((d) {
                          final selected = d.day == _selected.day && d.month == _selected.month;
                          final past = d.isBefore(DateTime.now().subtract(const Duration(days: 1)));
                          return GestureDetector(
                            onTap: past ? null : () => setState(() => _selected = d),
                            child: Container(
                              width: 38,
                              height: 38,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: selected ? AppColors.ink : Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(color: selected ? AppColors.ink : AppColors.line),
                              ),
                              child: Text('${d.day}',
                                  style: TextStyle(
                                    color: past
                                        ? AppColors.textOnLightMuted.withOpacity(0.35)
                                        : selected
                                            ? AppColors.textOnDark
                                            : AppColors.textOnLight,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Manrope',
                                  )),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                SmartCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Guests', style: Theme.of(context).textTheme.titleMedium),
                            Text('\$${widget.experience.pricePerPerson.toStringAsFixed(0)} per person',
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                      _stepper(
                        onMinus: _guests > 1 ? () => setState(() => _guests--) : null,
                        onPlus: _guests < 12 ? () => setState(() => _guests++) : null,
                        value: _guests,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _SummaryBar(
            total: total,
            buttonLabel: 'Continue',
            onContinue: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ReserveExperienceScreen(experience: widget.experience, date: _selected, guests: _guests),
            )),
          ),
        ],
      ),
    );
  }

  Widget _navChip(IconData icon, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(color: AppColors.cream, shape: BoxShape.circle),
          child: Icon(icon, size: 18, color: AppColors.textOnLight),
        ),
      );

  Widget _stepper({required VoidCallback? onMinus, required VoidCallback? onPlus, required int value}) {
    return Row(
      children: [
        _circleBtn(Icons.remove_rounded, onMinus),
        SizedBox(
            width: 30,
            child: Text('$value', textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'Manrope', fontWeight: FontWeight.w800))),
        _circleBtn(Icons.add_rounded, onPlus),
      ],
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback? onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: onTap == null ? AppColors.cream : AppColors.ink,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: onTap == null ? AppColors.textOnLightMuted : AppColors.textOnDark),
        ),
      );
}

class _SummaryBar extends StatelessWidget {
  final double total;
  final String buttonLabel;
  final VoidCallback onContinue;
  const _SummaryBar({required this.total, required this.buttonLabel, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      decoration: BoxDecoration(
        color: AppColors.card,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, -4))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total', style: Theme.of(context).textTheme.bodySmall),
                Text('\$${total.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(child: PrimaryButton(label: buttonLabel, onPressed: onContinue)),
        ],
      ),
    );
  }
}

class _AppBarLight extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const _AppBarLight({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.cream,
      elevation: 0,
      centerTitle: false,
      title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textOnLight, size: 18),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
