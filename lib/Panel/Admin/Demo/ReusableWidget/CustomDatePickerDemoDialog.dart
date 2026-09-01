import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomDatePickerDemoDialog extends StatefulWidget {
  final DateTime? initialDate;
  final VoidCallback onCancel;
  final Function(DateTime selectedDate) onDateSelected;

  const CustomDatePickerDemoDialog({
    super.key,
    this.initialDate,
    required this.onCancel,
    required this.onDateSelected,
  });

  @override
  State<CustomDatePickerDemoDialog> createState() =>
      _CustomDatePickerDemoDialogState();
}

class _CustomDatePickerDemoDialogState
    extends State<CustomDatePickerDemoDialog> {
  late DateTime _focusedMonth;
  late DateTime _selectedDate;
  final RxBool isMonthDropdownOpen = false.obs;
  final RxBool isYearDropdownOpen = false.obs;

  final List<String> _months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List<int> get _years {
    int currentYear = DateTime.now().year;
    return List<int>.generate((currentYear + 10) - 1950 + 1, (index) => 1950 + index);
  }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: AppColors.textColor, size: 16),
                onPressed: () {
                  setState(() {
                    _focusedMonth = DateTime(
                        _focusedMonth.year, _focusedMonth.month - 1, 1);
                  });
                },
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 6,
                child: PopupMenuButton<String>(
                  constraints: BoxConstraints(
                    minWidth: screenWidth < 350 ? 100 : 120,
                    maxWidth: 130,
                    maxHeight: 300,
                  ),
                  offset: const Offset(0, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
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
                    duration: const Duration(milliseconds: 10),
                    height: 36,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundOfScreenColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            currentMonthName,
                            overflow: TextOverflow.ellipsis,
                            style: TTextTheme.InsideAlreadyWrittenText(
                                context)
                                .copyWith(
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryColor.withValues(alpha: 0.08)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            month,
                            style: TTextTheme.titleSeven(context).copyWith(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.textColor,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
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
              Expanded(
                flex: 5,
                child: PopupMenuButton<int>(
                  constraints: BoxConstraints(
                    minWidth: screenWidth < 350 ? 80 : 90,
                    maxWidth: 105,
                    maxHeight: 300,
                  ),
                  offset: const Offset(0, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
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
                    duration: const Duration(milliseconds: 10),
                    height: 36,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundOfScreenColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _focusedMonth.year.toString(),
                          style: TTextTheme.InsideAlreadyWrittenText(
                              context)
                              .copyWith(
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryColor.withValues(alpha: 0.08)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            year.toString(),
                            style: TTextTheme.titleSeven(context).copyWith(
                              color: isSelected
                                  ? AppColors.textColor
                                  : AppColors.textColor,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
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
                icon: const Icon(Icons.arrow_forward_ios,
                    color: AppColors.textColor, size: 16),
                onPressed: () {
                  setState(() {
                    _focusedMonth = DateTime(
                        _focusedMonth.year, _focusedMonth.month + 1, 1);
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 14),
          Divider(color: AppColors.borderColor, height: 1),
          const SizedBox(height: 10),
          _buildCalendarGrid(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onCancel,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    side: BorderSide(color: AppColors.primaryColor, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Cancel",
                    style: TTextTheme.Numbers(context),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onDateSelected(_selectedDate);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 10),
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final daysInMonth =
    DateUtils.getDaysInMonth(_focusedMonth.year, _focusedMonth.month);
    final firstDayOffset =
        DateTime(_focusedMonth.year, _focusedMonth.month, 1).weekday - 1;

    final totalGridItems = ((daysInMonth + firstDayOffset) / 7).ceil() * 7;

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

        final cellDate =
        DateTime(_focusedMonth.year, _focusedMonth.month, dayNumber);
        bool isSelected = _isSameDay(cellDate, _selectedDate);

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = cellDate;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryColor : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "$dayNumber",
                style: TTextTheme.InsideAlreadyWrittenText(context).copyWith(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected
                      ? AppColors.whiteColor
                      : AppColors.textColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}