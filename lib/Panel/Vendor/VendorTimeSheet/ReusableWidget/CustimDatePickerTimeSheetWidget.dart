import 'package:employee_monitoring_system/Panel/Employee/ActivityTracking/ReusableWidget/PrimaryBtnOfActivity.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePickerTimeSheetWidget extends StatefulWidget {
  final DateTime? initialDate;
  final String timeFilterMode;
  final VoidCallback onCancel;
  final Function(DateTime selectedDate, DateTimeRange? weekRange) onDateSelected;

  const CustomDatePickerTimeSheetWidget({
    super.key,
    this.initialDate,
    required this.timeFilterMode,
    required this.onCancel,
    required this.onDateSelected,
  });

  @override
  State<CustomDatePickerTimeSheetWidget> createState() => _CustomDatePickerTimeSheetWidgetState();
}

class _CustomDatePickerTimeSheetWidgetState extends State<CustomDatePickerTimeSheetWidget> {
  late DateTime _focusedMonth;
  late DateTime _selectedDate;
  final DateTime _today = DateTime.now();

  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  late List<int> _years;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? _today;
    _focusedMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);

    int currentYear = _today.year;
    _years = List.generate(currentYear - 1950 + 1, (index) => 1950 + index).reversed.toList();
  }

  DateTimeRange _getSingleWeekRange(DateTime date) {
    int currentDayOfWeek = date.weekday;
    DateTime startOfWeek = date.subtract(Duration(days: currentDayOfWeek - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
    return DateTimeRange(
      start: DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
      end: DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day),
    );
  }

  DateTimeRange _getLast4WeeksRange(DateTime date) {
    DateTime endOfWeek = _getSingleWeekRange(date).end;
    DateTime startOf4Weeks = endOfWeek.subtract(const Duration(days: 27));
    return DateTimeRange(
      start: DateTime(startOf4Weeks.year, startOf4Weeks.month, startOf4Weeks.day),
      end: DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day),
    );
  }

  bool _isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isFutureDate(DateTime date) {
    final todayOnly = DateTime(_today.year, _today.month, _today.day);
    final dateOnly = DateTime(date.year, date.month, date.day);
    return dateOnly.isAfter(todayOnly);
  }

  String get _bottomDisplayText {
    if (widget.timeFilterMode == "Day") {
      return "Selected Day: ${DateFormat('d MMMM, yyyy').format(_selectedDate)}";
    } else if (widget.timeFilterMode == "Week") {
      final range = _getSingleWeekRange(_selectedDate);
      return "Selected Week: ${DateFormat('d MMM, yyyy').format(range.start)} to ${DateFormat('d MMM, yyyy').format(range.end)}";
    } else {
      final range = _getLast4WeeksRange(_selectedDate);
      return "Selected Weeks: ${DateFormat('d MMM, yy').format(range.start)} to ${DateFormat('d MMM, yy').format(range.end)}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dialogWidth = screenWidth < 360 ? screenWidth * 0.95 : 330.0;

    return Container(
      width: dialogWidth,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
                icon: const Icon(Icons.chevron_left, color: AppColors.textColor, size: 22),
                onPressed: () {
                  setState(() {
                    _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1, 1);
                  });
                },
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child: _buildMonthPopupMenu()),
                    const SizedBox(width: 6),
                    Flexible(child: _buildYearSearchPopupMenu()),
                  ],
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
                icon: const Icon(Icons.chevron_right, color: AppColors.textColor, size: 22),
                onPressed: () {
                  setState(() {
                    _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 1);
                  });
                },
              ),
            ],
          ),

          const Divider(color: AppColors.borderColor, height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: const [
                SizedBox(width: 28),
                Expanded(child: Center(child: _WeekdayLabel("Mon"))),
                Expanded(child: Center(child: _WeekdayLabel("Tue"))),
                Expanded(child: Center(child: _WeekdayLabel("Wed"))),
                Expanded(child: Center(child: _WeekdayLabel("Thu"))),
                Expanded(child: Center(child: _WeekdayLabel("Fri"))),
                Expanded(child: Center(child: _WeekdayLabel("Sat"))),
                Expanded(child: Center(child: _WeekdayLabel("Sun"))),
              ],
            ),
          ),
          _buildCalendarGrid(),

          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.backgroundOfScreenColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: AppColors.primaryColor, size: 18),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _bottomDisplayText,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: widget.onCancel,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                  minimumSize: const Size(64, 34),
                  side: const BorderSide(color: AppColors.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Cancel", style: TTextTheme.Numbers(context).copyWith(fontSize: 12)),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 76,
                height: 40,
                child: PrimaryBtnOfActivity(
                  text: "Done",
                  height: 34,
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    if (widget.timeFilterMode == "Week") {
                      widget.onDateSelected(_selectedDate, _getSingleWeekRange(_selectedDate));
                    } else if (widget.timeFilterMode == "Last 4 week") {
                      widget.onDateSelected(_selectedDate, _getLast4WeeksRange(_selectedDate));
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

  /// ------------- Extra Widget ------------///

  //Custom Month Dropdown
  Widget _buildMonthPopupMenu() {
    return PopupMenuButton<int>(
      constraints: const BoxConstraints(maxHeight: 220, minWidth: 120),
      offset: const Offset(0, 36),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: AppColors.whiteColor,
      onSelected: (monthIndex) {
        setState(() {
          _focusedMonth = DateTime(_focusedMonth.year, monthIndex, 1);
        });
      },
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.backgroundOfScreenColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                _months[_focusedMonth.month - 1],
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textColor),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_drop_down, size: 16, color: AppColors.textColor),
          ],
        ),
      ),
      itemBuilder: (context) => List.generate(12, (index) {
        bool isSelected = _focusedMonth.month == (index + 1);
        return PopupMenuItem<int>(
          height: 34,
          value: index + 1,
          child: Row(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryColor, width: 1.5),
                  color: isSelected ? AppColors.primaryColor : Colors.transparent,
                ),
                child: isSelected ? const Icon(Icons.done, size: 10, color: AppColors.whiteColor) : null,
              ),
              const SizedBox(width: 8),
              Text(
                _months[index],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.primaryColor : AppColors.textColor,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  /// Searchable Year Dropdown
  Widget _buildYearSearchPopupMenu() {
    return PopupMenuButton<int>(
      constraints: const BoxConstraints(maxHeight: 250, minWidth: 140, maxWidth: 160),
      offset: const Offset(0, 36),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: AppColors.whiteColor,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.backgroundOfScreenColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${_focusedMonth.year}",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textColor),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_drop_down, size: 16, color: AppColors.textColor),
          ],
        ),
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem<int>(
            enabled: false,
            height: 48,
            child: StatefulBuilder(
              builder: (context, menuSetState) {
                return _YearSearchMenuList(
                  years: _years,
                  selectedYear: _focusedMonth.year,
                  onYearSelected: (year) {
                    Navigator.pop(context);
                    setState(() {
                      _focusedMonth = DateTime(year, _focusedMonth.month, 1);
                    });
                  },
                );
              },
            ),
          ),
        ];
      },
    );
  }

  Widget _buildCalendarGrid() {
    final daysInMonth = DateUtils.getDaysInMonth(_focusedMonth.year, _focusedMonth.month);
    final firstDayOffset = DateTime(_focusedMonth.year, _focusedMonth.month, 1).weekday - 1;
    final totalWeeks = ((daysInMonth + firstDayOffset) / 7).ceil();

    DateTimeRange? activeRange;
    if (widget.timeFilterMode == "Week") {
      activeRange = _getSingleWeekRange(_selectedDate);
    } else if (widget.timeFilterMode == "Last 4 week") {
      activeRange = _getLast4WeeksRange(_selectedDate);
    }

    return Column(
      children: List.generate(totalWeeks, (weekIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: [
              SizedBox(
                width: 28,
                child: Text(
                  "W${weekIndex + 1}",
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: List.generate(7, (dayOfWeekIndex) {
                    int dayNumber = (weekIndex * 7) + dayOfWeekIndex - firstDayOffset + 1;

                    if (dayNumber < 1 || dayNumber > daysInMonth) {
                      return const Expanded(child: SizedBox(height: 28));
                    }

                    final cellDate = DateTime(_focusedMonth.year, _focusedMonth.month, dayNumber);
                    bool isSelectedDay = _isSameDay(cellDate, _selectedDate);
                    bool isFuture = _isFutureDate(cellDate);

                    bool isInSelectedRange = false;
                    bool isStartOfRow = dayOfWeekIndex == 0;
                    bool isEndOfRow = dayOfWeekIndex == 6;

                    if (widget.timeFilterMode != "Day" && activeRange != null) {
                      DateTime dateOnly = DateTime(cellDate.year, cellDate.month, cellDate.day);
                      DateTime startOnly = DateTime(activeRange.start.year, activeRange.start.month, activeRange.start.day);
                      DateTime endOnly = DateTime(activeRange.end.year, activeRange.end.month, activeRange.end.day);

                      isInSelectedRange = (dateOnly.isAtSameMomentAs(startOnly) || dateOnly.isAfter(startOnly)) &&
                          (dateOnly.isAtSameMomentAs(endOnly) || dateOnly.isBefore(endOnly));

                      if (dateOnly.isAtSameMomentAs(startOnly)) isStartOfRow = true;
                      if (dateOnly.isAtSameMomentAs(endOnly)) isEndOfRow = true;
                    }

                    return Expanded(
                      child: GestureDetector(
                        onTap: isFuture
                            ? null
                            : () {
                          setState(() {
                            _selectedDate = cellDate;
                          });
                        },
                        child: Container(
                          height: 28,
                          decoration: BoxDecoration(
                            color: (isInSelectedRange && !isFuture) ? AppColors.primaryColor : Colors.transparent,
                            borderRadius: widget.timeFilterMode != "Day" && isInSelectedRange
                                ? BorderRadius.horizontal(
                              left: isStartOfRow ? const Radius.circular(14) : Radius.zero,
                              right: isEndOfRow ? const Radius.circular(14) : Radius.zero,
                            )
                                : null,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: (widget.timeFilterMode == "Day" && isSelectedDay) ? AppColors.primaryColor : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                "$dayNumber",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: (isSelectedDay || isInSelectedRange) ? FontWeight.w600 : FontWeight.w400,
                                  color: isFuture
                                      ? AppColors.tertiaryTextColor.withValues(alpha: 0.3)
                                      : ((isSelectedDay || isInSelectedRange) ? AppColors.whiteColor : AppColors.textColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

/// Class Year Selector
class _YearSearchMenuList extends StatefulWidget {
  final List<int> years;
  final int selectedYear;
  final Function(int year) onYearSelected;

  const _YearSearchMenuList({
    required this.years,
    required this.selectedYear,
    required this.onYearSelected,
  });

  @override
  State<_YearSearchMenuList> createState() => _YearSearchMenuListState();
}

class _YearSearchMenuListState extends State<_YearSearchMenuList> {
  late List<int> filteredYears;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredYears = List.from(widget.years);
  }

  void _filterYears(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredYears = List.from(widget.years);
      } else {
        filteredYears = widget.years.where((year) => year.toString().contains(query)).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 200,
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            height: 32,
            margin: const EdgeInsets.only(bottom: 6),
            child: TextField(
              cursorColor: AppColors.textColor,
              controller: _searchController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 11),
              onChanged: _filterYears,
              decoration: InputDecoration(
                hintText: "Search Year...",
                hintStyle: TTextTheme.FieldWriteTheText(context),
                prefixIcon: const Icon(Icons.search, size: 14, color: AppColors.textColor),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                fillColor: AppColors.backgroundOfScreenColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const Divider(height: 1, thickness: 0.5),
          Expanded(
            child: filteredYears.isEmpty
                ? const Center(
              child: Text("No Year Found", style: TextStyle(fontSize: 10, color: Colors.grey)),
            )
                : ListView.builder(
              itemCount: filteredYears.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final year = filteredYears[index];
                final bool isSelected = year == widget.selectedYear;

                return InkWell(
                  onTap: () => widget.onYearSelected(year),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primaryColor, width: 1.5),
                            color: isSelected ? AppColors.primaryColor : Colors.transparent,
                          ),
                          child: isSelected ? const Icon(Icons.done, size: 10, color: AppColors.whiteColor) : null,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "$year",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? AppColors.primaryColor : AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _WeekdayLabel extends StatelessWidget {
  final String label;
  const _WeekdayLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: TTextTheme.InsideAlreadyWrittenText(context).copyWith(fontSize: 11),
    );
  }
}