import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDatePickerScreenshotDialog extends StatefulWidget {
  final DateTime? initialDate;
  final bool isWeekMode;
  final VoidCallback onCancel;
  final Function(DateTime selectedDate, DateTimeRange? weekRange) onDateSelected;

  const CustomDatePickerScreenshotDialog({
    super.key,
    this.initialDate,
    required this.isWeekMode,
    required this.onCancel,
    required this.onDateSelected,
  });

  @override
  State<CustomDatePickerScreenshotDialog> createState() => _CustomDatePickerScreenshotDialogState();
}

class _CustomDatePickerScreenshotDialogState extends State<CustomDatePickerScreenshotDialog> {
  late DateTime _focusedMonth;
  late DateTime _selectedDate;
  final RxBool isMonthDropdownOpen = false.obs;
  final RxBool isYearDropdownOpen = false.obs;

  final List<String> _months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  List<int> get _years {
    int currentYear = DateTime.now().year;
    return List<int>.generate(currentYear - 1950 + 1, (index) => 1950 + index);
  }

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

    // Fixed Width hatakar padding responsive kar di taaki kisi bhi choti screen par stick na ho
    final double dialogWidth = screenWidth < 380 ? screenWidth * 0.92 : 340.0;
    String currentMonthName = _months[_focusedMonth.month - 1];

    return Container(
      width: dialogWidth,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
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
          // --- Fixed Header Row with Expanded Dropdowns ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textColor, size: 16),
                onPressed: () {
                  setState(() {
                    _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1, 1);
                  });
                },
              ),
              const SizedBox(width: 4),

              // 1. Month Dropdown Wrapper
              Expanded(
                flex: 6,
                child: PopupMenuButton<String>(
                  // constraints ko responsive banaya taaki choti screen par dropdown width automatic shrink ho jaye
                  constraints: BoxConstraints(
                    minWidth: screenWidth < 350 ? 100 : 120,
                    maxWidth: 130,
                    maxHeight: 300,
                  ),
                  offset: const Offset(0, 40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  color: AppColors.whiteColor,
                  elevation: 4,
                  onOpened: () => isMonthDropdownOpen.value = true,
                  onCanceled: () => isMonthDropdownOpen.value = false,
                  onSelected: (String val) {
                    setState(() {
                      int index = _months.indexOf(val) + 1;
                      _focusedMonth = DateTime(_focusedMonth.year, index, 1);
                    });
                    isMonthDropdownOpen.value = false;
                  },
                  child: Obx(() => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            currentMonthName,
                            overflow: TextOverflow.ellipsis, // Text cut na ho balki dots (...) ban jaye agar screen super small ho
                            style: TTextTheme.InsideAlreadyWrittenText(context).copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 2),
                        Icon(
                          isMonthDropdownOpen.value
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: AppColors.textColor,
                          size: 16,
                        ),
                      ],
                    ),
                  )),
                  itemBuilder: (BuildContext context) {
                    return _months.map((String month) {
                      final bool isSelected = month == currentMonthName;
                      return PopupMenuItem<String>(
                        value: month,
                        height: 38,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryColor.withOpacity(0.08)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            month,
                            style: TTextTheme.titleSeven(context).copyWith(
                              color: isSelected ? AppColors.primaryColor : AppColors.textColor,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              const SizedBox(width: 6),

              // 2. Year Dropdown Wrapper
              Expanded(
                flex: 5,
                child: PopupMenuButton<int>(
                  constraints: BoxConstraints(
                    minWidth: screenWidth < 350 ? 80 : 90,
                    maxWidth: 105,
                    maxHeight: 300,
                  ),
                  offset: const Offset(0, 40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  color: AppColors.whiteColor,
                  elevation: 4,
                  onOpened: () => isYearDropdownOpen.value = true,
                  onCanceled: () => isYearDropdownOpen.value = false,
                  onSelected: (int val) {
                    setState(() {
                      _focusedMonth = DateTime(val, _focusedMonth.month, 1);
                    });
                    isYearDropdownOpen.value = false;
                  },
                  child: Obx(() => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _focusedMonth.year.toString(),
                          style: TTextTheme.InsideAlreadyWrittenText(context).copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textColor,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Icon(
                          isYearDropdownOpen.value
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: AppColors.textColor,
                          size: 16,
                        ),
                      ],
                    ),
                  )),
                  itemBuilder: (BuildContext context) {
                    return _years.map((int year) {
                      final bool isSelected = year == _focusedMonth.year;
                      return PopupMenuItem<int>(
                        value: year,
                        height: 38,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryColor.withOpacity(0.08)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            year.toString(),
                            style: TTextTheme.titleSeven(context).copyWith(
                              color: isSelected ? AppColors.primaryColor : AppColors.textColor,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              const SizedBox(width: 4),

              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.arrow_forward_ios, color: AppColors.textColor, size: 16),
                onPressed: () {
                  setState(() {
                    _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 1);
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 14),
          const Divider(color: Color(0xFFE2E8F0), height: 1),
          const SizedBox(height: 10),

          // --- Weekdays Header ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
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
          const SizedBox(height: 4),

          // --- Calendar Grid ---
          _buildCalendarGrid(),

          const SizedBox(height: 16),

          // --- Fixed Buttons Row to Avoid Side Overflow ---
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onCancel,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    side: const BorderSide(color: Color(0xFF3B82F6), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.isWeekMode) {
                      final range = _getWeekRange(_selectedDate);
                      widget.onDateSelected(_selectedDate, range);
                    } else {
                      widget.onDateSelected(_selectedDate, null);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Done",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
                  ? const Color(0xFF3B82F6)
                  : (isInWeek ? const Color(0xFF3B82F6).withOpacity(0.12) : Colors.transparent),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "$dayNumber",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : (isInWeek ? const Color(0xFF3B82F6) : const Color(0xFF1E293B)),
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
        style: TTextTheme.InsideAlreadyWrittenText(context).copyWith(fontSize: 12),
      ),
    );
  }
}