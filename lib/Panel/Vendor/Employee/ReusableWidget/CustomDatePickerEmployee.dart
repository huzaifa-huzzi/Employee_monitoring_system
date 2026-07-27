import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

class CustomDatePickerEmployee extends StatefulWidget {
  final DateTime? initialDate;
  final VoidCallback onCancel;
  final Function(DateTime selectedDate) onDateSelected;

  const CustomDatePickerEmployee({
    super.key,
    this.initialDate,
    required this.onCancel,
    required this.onDateSelected,
  });

  @override
  State<CustomDatePickerEmployee> createState() => _CustomDatePickerEmployeeState();
}

class _CustomDatePickerEmployeeState extends State<CustomDatePickerEmployee> {
  late DateTime _focusedMonth;
  late DateTime _selectedDate;

  final List<String> _months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _focusedMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
  }

  bool _isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dialogWidth = screenWidth < 380 ? screenWidth * 0.92 : 320.0;
    String currentMonthName = _months[_focusedMonth.month - 1];

    return Container(
      width: dialogWidth,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textColor, size: 18),
                onPressed: () {
                  setState(() {
                    _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1, 1);
                  });
                },
              ),
              Text(
                currentMonthName,
                style: TTextTheme.InsideAlreadyWrittenText(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                  fontSize: 16,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.arrow_forward_ios, color: AppColors.textColor, size: 18),
                onPressed: () {
                  setState(() {
                    _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 1);
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 12),
          Divider(color: AppColors.borderColor.withOpacity(0.5), height: 1),
          const SizedBox(height: 12),
          Row(
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
          const SizedBox(height: 8),
          _buildCalendarGrid(),

          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: widget.onCancel,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  side: const BorderSide(color: AppColors.primaryColor, width: 1.5),
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
              ElevatedButton(
                onPressed: () {
                  widget.onDateSelected(_selectedDate);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Done",
                  style: TTextTheme.btnTextOne(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  /// ------------ Extra Widget ------------- ///

   // Calendar Grid
  Widget _buildCalendarGrid() {
    final daysInMonth = DateUtils.getDaysInMonth(_focusedMonth.year, _focusedMonth.month);
    final firstDayOffset = DateTime(_focusedMonth.year, _focusedMonth.month, 1).weekday - 1;

    final totalGridItems = ((daysInMonth + firstDayOffset) / 7).ceil() * 7;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: totalGridItems,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
      itemBuilder: (context, index) {
        int dayNumber = index - firstDayOffset + 1;

        if (dayNumber < 1 || dayNumber > daysInMonth) {
          return const SizedBox.shrink();
        }

        final cellDate = DateTime(_focusedMonth.year, _focusedMonth.month, dayNumber);
        bool isSelected = _isSameDay(cellDate, _selectedDate);

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = cellDate;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryColor : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "$dayNumber",
                style: TTextTheme.InsideAlreadyWrittenText(context).copyWith(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? AppColors.whiteColor : AppColors.textColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _WeekdayLabel extends StatelessWidget {
  final String label;
  const _WeekdayLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TTextTheme.InsideAlreadyWrittenText(context).copyWith(
          fontSize: 12,
          color: AppColors.tertiaryTextColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}