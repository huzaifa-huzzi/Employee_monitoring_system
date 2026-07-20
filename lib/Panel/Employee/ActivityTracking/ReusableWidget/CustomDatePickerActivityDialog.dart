import 'package:employee_monitoring_system/Panel/Employee/ActivityTracking/ReusableWidget/PrimaryBtnOfActivity.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePickerActivityDialog extends StatefulWidget {
  final DateTime? initialDate;
  final bool isWeekMode;
  final VoidCallback onCancel;
  final Function(DateTime selectedDate, DateTimeRange? weekRange) onDateSelected;

  const CustomDatePickerActivityDialog({
    super.key,
    this.initialDate,
    required this.isWeekMode,
    required this.onCancel,
    required this.onDateSelected,
  });

  @override
  State<CustomDatePickerActivityDialog> createState() => _CustomDatePickerActivityDialogState();
}

class _CustomDatePickerActivityDialogState extends State<CustomDatePickerActivityDialog> {
  late DateTime _focusedMonth;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _focusedMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
  }

  DateTimeRange _getWeekRange(DateTime date) {
    int currentDayOfWeek = date.weekday;
    DateTime startOfWeek = date.subtract(Duration(days: currentDayOfWeek - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
    return DateTimeRange(
      start: DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
      end: DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day),
    );
  }

  bool _isDateInWeekRange(DateTime day, DateTimeRange range) {
    final dateOnly = DateTime(day.year, day.month, day.day);
    return (dateOnly.isAfter(range.start.subtract(const Duration(days: 1))) &&
        dateOnly.isBefore(range.end.add(const Duration(days: 1))));
  }

  bool _isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dialogWidth = screenWidth < 380 ? screenWidth * 0.9 : 320.0;

    return Container(
      width: dialogWidth,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Month navigation bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: AppColors.textColor),
                onPressed: () {
                  setState(() {
                    _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1, 1);
                  });
                },
              ),
              Text(
                DateFormat('MMMM yyyy').format(_focusedMonth),
                style: TTextTheme.titleOne(context).copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: AppColors.textColor),
                onPressed: () {
                  setState(() {
                    _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 1);
                  });
                },
              ),
            ],
          ),

          const Divider(color: AppColors.borderColor, height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _WeekdayLabel("Mon"),
                _WeekdayLabel("Tue"),
                _WeekdayLabel("Wed"),
                _WeekdayLabel("Thu"),
                _WeekdayLabel("Fri"),
                _WeekdayLabel("Sat"),
                _WeekdayLabel("Sun"),
              ],
            ),
          ),

          _buildCalendarGrid(),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: widget.onCancel,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  side: const BorderSide(color: AppColors.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Cancel",
                  style: TTextTheme.Numbers(context),
                ),
              ),
              const SizedBox(width: 10),

              SizedBox(
                width: 80,
                height: 38,
                child: PrimaryBtnOfActivity(
                  text: "Done",
                  height: 38,
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    if (widget.isWeekMode) {
                      final range = _getWeekRange(_selectedDate);
                      widget.onDateSelected(_selectedDate, range);
                    } else {
                      widget.onDateSelected(_selectedDate, null);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

    /// -----------Extra Widget --------- ///
  Widget _buildCalendarGrid() {
    final daysInMonth = DateUtils.getDaysInMonth(_focusedMonth.year, _focusedMonth.month);
    final firstDayOffset = DateTime(_focusedMonth.year, _focusedMonth.month, 1).weekday - 1;

    final totalGridItems = ((daysInMonth + firstDayOffset) / 7).ceil() * 7;
    final weekRange = widget.isWeekMode ? _getWeekRange(_selectedDate) : null;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: totalGridItems,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        int dayNumber = index - firstDayOffset + 1;

        if (dayNumber < 1 || dayNumber > daysInMonth) {
          return const SizedBox.shrink();
        }

        final cellDate = DateTime(_focusedMonth.year, _focusedMonth.month, dayNumber);

        bool isSelected = _isSameDay(cellDate, _selectedDate);
        bool isInWeek = widget.isWeekMode && weekRange != null && _isDateInWeekRange(cellDate, weekRange);

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = cellDate;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryColor
                  : (isInWeek ? AppColors.primaryColor.withValues(alpha: 0.12) : Colors.transparent),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "$dayNumber",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: (isSelected || isInWeek) ? FontWeight.bold : FontWeight.w500,
                  color: isSelected
                      ? AppColors.whiteColor
                      : (isInWeek ? AppColors.primaryColor : AppColors.tertiaryTextColor),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// ---------- Extra class ------------ ///
class _WeekdayLabel extends StatelessWidget {
  final String label;
  const _WeekdayLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TTextTheme.InsideAlreadyWrittenText(context),
      ),
    );
  }
}
