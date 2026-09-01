import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:flutter/material.dart';



class CustomTimePickerDialog extends StatefulWidget {
  final String initialTime;
  final ValueChanged<String> onTimeSelected;

  const CustomTimePickerDialog({
    super.key,
    required this.initialTime,
    required this.onTimeSelected,
  });

  @override
  State<CustomTimePickerDialog> createState() => _CustomTimePickerDialogState();
}

class _CustomTimePickerDialogState extends State<CustomTimePickerDialog> {
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;

  int _selectedHour = 12;
  int _selectedMinute = 0;
  String _selectedPeriod = 'AM';

  final List<int> _hours = List.generate(12, (index) => index + 1);
  final List<int> _minutes = List.generate(60, (index) => index);

  @override
  void initState() {
    super.initState();
    _parseInitialTime();

    _hourController = FixedExtentScrollController(
      initialItem: _hours.contains(_selectedHour)
          ? _hours.indexOf(_selectedHour)
          : 0,
    );
    _minuteController = FixedExtentScrollController(
      initialItem: _selectedMinute,
    );
  }

  void _parseInitialTime() {
    try {
      String timeStr = widget.initialTime.trim().toLowerCase();
      if (timeStr.contains('am')) {
        _selectedPeriod = 'AM';
        timeStr = timeStr.replaceAll('am', '').trim();
      } else if (timeStr.contains('pm')) {
        _selectedPeriod = 'PM';
        timeStr = timeStr.replaceAll('pm', '').trim();
      } else {
        final now = TimeOfDay.now();
        _selectedHour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
        _selectedMinute = now.minute;
        _selectedPeriod = now.period == DayPeriod.am ? 'AM' : 'PM';
        return;
      }

      final parts = timeStr.split(':');
      if (parts.length == 2) {
        _selectedHour = int.parse(parts[0]);
        _selectedMinute = int.parse(parts[1]);
      }
    } catch (_) {
      final now = TimeOfDay.now();
      _selectedHour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
      _selectedMinute = now.minute;
      _selectedPeriod = now.period == DayPeriod.am ? 'AM' : 'PM';
    }
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 120,
              child: Row(
                children: [
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                      controller: _hourController,
                      itemExtent: 36,
                      perspective: 0.005,
                      diameterRatio: 1.2,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedHour = _hours[index];
                        });
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: _hours.length,
                        builder: (context, index) {
                          final isSelected = _hours[index] == _selectedHour;
                          return Center(
                            child: Text(
                              _hours[index].toString().padLeft(2, '0'),
                              style: TextStyle(
                                fontSize: isSelected ? 22 : 16,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? AppColors.textColor
                                    : AppColors.tertiaryTextColor
                                    .withValues(alpha: 0.5),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const Text(
                    ":",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),

                  // Minute Wheel
                  Expanded(
                    child: ListWheelScrollView.useDelegate(
                      controller: _minuteController,
                      itemExtent: 36,
                      perspective: 0.005,
                      diameterRatio: 1.2,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedMinute = _minutes[index];
                        });
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: _minutes.length,
                        builder: (context, index) {
                          final isSelected = _minutes[index] == _selectedMinute;
                          return Center(
                            child: Text(
                              _minutes[index].toString().padLeft(2, '0'),
                              style: TextStyle(
                                fontSize: isSelected ? 22 : 16,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? AppColors.textColor
                                    : AppColors.tertiaryTextColor
                                    .withValues(alpha: 0.5),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // AM / PM Selector Toggle
                  Container(
                    width: 54,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundOfScreenColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() => _selectedPeriod = 'AM'),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: _selectedPeriod == 'AM'
                                    ? AppColors.primaryColor.withValues(alpha: 0.15)
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(8)),
                              ),
                              child: Text(
                                "AM",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: _selectedPeriod == 'AM'
                                      ? AppColors.primaryColor
                                      : AppColors.tertiaryTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() => _selectedPeriod = 'PM'),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: _selectedPeriod == 'PM'
                                    ? AppColors.primaryColor.withValues(alpha: 0.15)
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(8)),
                              ),
                              child: Text(
                                "PM",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: _selectedPeriod == 'PM'
                                      ? AppColors.primaryColor
                                      : AppColors.tertiaryTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        color: AppColors.primaryColor.withValues(alpha: 0.5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final formattedHour =
                    _selectedHour.toString().padLeft(2, '0');
                    final formattedMinute =
                    _selectedMinute.toString().padLeft(2, '0');
                    final resultTime =
                        "$formattedHour:$formattedMinute${_selectedPeriod.toLowerCase()}";

                    widget.onTimeSelected(resultTime);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 8),
                  ),
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}