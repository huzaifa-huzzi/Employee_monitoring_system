import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';

class EmployeeDetailViewWidget extends StatefulWidget {
  final dynamic employee;
  final String selectedFilter;

  const EmployeeDetailViewWidget({
    super.key,
    this.employee,
    required this.selectedFilter,
  });

  @override
  State<EmployeeDetailViewWidget> createState() => _EmployeeDetailViewWidgetState();
}

class _EmployeeDetailViewWidgetState extends State<EmployeeDetailViewWidget> {
  final List<Map<String, dynamic>> weeklyLogs = [
    {"duration": "Monday", "total": "8hrs", "active": "6hrs 50mints", "idle": "1hr 10mints", "productivity": "70%"},
    {"duration": "Tuesday", "total": "8hrs", "active": "6hrs 50mints", "idle": "1hr 10mints", "productivity": "80%"},
    {"duration": "Wednesday", "total": "8hrs", "active": "6hrs 45mints", "idle": "1hr 15mints", "productivity": "70%"},
    {"duration": "Thursday", "total": "8hrs", "active": "7hrs 10mints", "idle": "50mints", "productivity": "85%"},
    {"duration": "Friday", "total": "8hrs", "active": "7hrs 10mints", "idle": "50mints", "productivity": "70%"},
    {"duration": "Saturday", "total": "-----", "active": "-------", "idle": "------", "productivity": "------"},
    {"duration": "Sunday", "total": "-----", "active": "-------", "idle": "------", "productivity": "------"},
  ];

  late final List<Map<String, dynamic>> last4WeeksLogs = List.generate(25, (index) {
    int day = index + 1;
    bool isOff = (day % 6 == 0 || day % 7 == 0);
    return {
      "duration": "$day May, 2026",
      "total": isOff ? "-----" : "${(index % 2 == 0) ? 8 : 9}hrs",
      "active": isOff ? "-------" : "6hrs 50mints",
      "idle": isOff ? "------" : "1hr 10mints",
      "productivity": isOff ? "------" : "${70 + (index % 4) * 5}%",
    };
  });
  late List<bool> _selectedRows;
  bool _isHeaderSelected = false;
  bool _isTotalSelected = false;

  @override
  void initState() {
    super.initState();
    _initSelectionStates();
  }

  @override
  void didUpdateWidget(covariant EmployeeDetailViewWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedFilter != widget.selectedFilter) {
      _initSelectionStates();
    }
  }

  void _initSelectionStates() {
    int count = widget.selectedFilter == "Last 4 week"
        ? last4WeeksLogs.length
        : weeklyLogs.length;
    _selectedRows = List<bool>.filled(count, false);
    _isHeaderSelected = false;
    _isTotalSelected = false;
  }

  void _toggleSelectAll(bool? val) {
    if (val == null) return;
    setState(() {
      _isHeaderSelected = val;
      _isTotalSelected = val;
      for (int i = 0; i < _selectedRows.length; i++) {
        _selectedRows[i] = val;
      }
    });
  }

  void _onRowSelected(int index, bool? val) {
    if (val == null) return;
    setState(() {
      _selectedRows[index] = val;
      _isHeaderSelected = _selectedRows.every((e) => e == true) && _isTotalSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.person_outline, size: 24, color: AppColors.primaryColor),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.employee?.name ?? "Jack Milson",
                    style: TTextTheme.h2Style(context).copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.employee?.email ?? widget.employee?.designation ?? "jack@gmail.com",
                    style: TTextTheme.titleSix(context).copyWith(fontSize: 12, color: AppColors.tertiaryTextColor),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),
          if (widget.selectedFilter == "Day")
            _buildDayViewWidget(context)
          else
            _buildTableViewWidget(context),
        ],
      ),
    );
  }

  /// ---------- Extra Widget--------------///

  //  Day
  Widget _buildDayViewWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: AppColors.borderColor, thickness: 0.8),
        const SizedBox(height: 16),
        Text(
          "Time Logs & Screenshot Timeline",
          style: TTextTheme.h2Style(context).copyWith(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Container(
          height: 220,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.backgroundOfScreenColor.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "Activity Log for filter: Day",
            style: TTextTheme.titleSix(context).copyWith(color: AppColors.tertiaryTextColor, fontSize: 13),
          ),
        ),
      ],
    );
  }

  // Table View
  Widget _buildTableViewWidget(BuildContext context) {
    bool isLast4Weeks = widget.selectedFilter == "Last 4 week";
    List<Map<String, dynamic>> logs = isLast4Weeks ? last4WeeksLogs : weeklyLogs;
    Map<String, dynamic> totalData = isLast4Weeks
        ? {
      "duration": "Total",
      "total": "160hrs",
      "active": "134hr 45mints",
      "idle": "5hr 15mints",
      "productivity": "78%",
    }
        : {
      "duration": "Total",
      "total": "48hrs",
      "active": "34hr 45mints",
      "idle": "5hr 15mints",
      "productivity": "78%",
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        const double minWidth = 700;
        double tableWidth = constraints.maxWidth < minWidth ? minWidth : constraints.maxWidth;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: tableWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundOfScreenColor.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: _isHeaderSelected,
                          onChanged: _toggleSelectAll,
                          activeColor: AppColors.primaryColor,
                          side: const BorderSide(color: AppColors.borderColor, width: 1.5),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(flex: 2, child: Text("Duration", style: TTextTheme.textFieldAboveText(context))),
                      Expanded(flex: 2, child: Text("Total time", style: TTextTheme.textFieldAboveText(context))),
                      Expanded(flex: 2, child: Text("Active Time", style: TTextTheme.textFieldAboveText(context))),
                      Expanded(flex: 2, child: Text("Idle Time", style: TTextTheme.textFieldAboveText(context))),
                      Expanded(flex: 2, child: Text("Productivity", style: TTextTheme.textFieldAboveText(context))),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                ...List.generate(logs.length, (index) {
                  return _buildDetailRow(
                    context,
                    logs[index],
                    isSelected: index < _selectedRows.length ? _selectedRows[index] : false,
                    onChanged: (val) => _onRowSelected(index, val),
                    isTotalRow: false,
                  );
                }),
                _buildDetailRow(
                  context,
                  totalData,
                  isSelected: _isTotalSelected,
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _isTotalSelected = val;
                        _isHeaderSelected = _selectedRows.every((e) => e == true) && _isTotalSelected;
                      });
                    }
                  },
                  isTotalRow: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Row Builder
  Widget _buildDetailRow(
      BuildContext context,
      Map<String, dynamic> data, {
        required bool isSelected,
        required ValueChanged<bool?> onChanged,
        required bool isTotalRow,
      }) {
    TextStyle textStyle = isTotalRow
        ? TTextTheme.h2Style(context).copyWith(fontSize: 13, fontWeight: FontWeight.bold)
        : TTextTheme.titleSix(context).copyWith(fontSize: 12);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: isSelected,
              onChanged: onChanged,
              activeColor: AppColors.primaryColor,
              side: const BorderSide(color: AppColors.borderColor, width: 1.5),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(flex: 2, child: Text(data["duration"], style: textStyle)),
          Expanded(flex: 2, child: Text(data["total"], style: textStyle)),
          Expanded(flex: 2, child: Text(data["active"], style: textStyle)),
          Expanded(flex: 2, child: Text(data["idle"], style: textStyle)),
          Expanded(flex: 2, child: Text(data["productivity"], style: textStyle)),
        ],
      ),
    );
  }
}