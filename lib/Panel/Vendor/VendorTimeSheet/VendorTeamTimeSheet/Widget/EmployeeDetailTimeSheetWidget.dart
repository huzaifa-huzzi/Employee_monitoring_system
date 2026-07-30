import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';


class EmployeeDetailViewWidget extends StatefulWidget {
  final dynamic employee;
  final VoidCallback? onBackTap;

  const EmployeeDetailViewWidget({
    super.key,
    this.employee,
    this.onBackTap,
  });

  @override
  State<EmployeeDetailViewWidget> createState() => _EmployeeDetailViewWidgetState();
}

class _EmployeeDetailViewWidgetState extends State<EmployeeDetailViewWidget> {
  final List<Map<String, dynamic>> dailyLogs = [
    {"duration": "Monday", "total": "8hrs", "active": "6hrs 50mints", "idle": "1hr 10mints", "productivity": "70%"},
    {"duration": "Tuesday", "total": "8hrs", "active": "6hrs 50mints", "idle": "1hr 10mints", "productivity": "80%"},
    {"duration": "Wednesday", "total": "8hrs", "active": "6hrs 45mints", "idle": "1hr 15mints", "productivity": "70%"},
    {"duration": "Thursday", "total": "8hrs", "active": "7hrs 10mints", "idle": "50mints", "productivity": "85%"},
    {"duration": "Friday", "total": "8hrs", "active": "7hrs 10mints", "idle": "50mints", "productivity": "70%"},
    {"duration": "Saturday", "total": "-----", "active": "-------", "idle": "------", "productivity": "------"},
    {"duration": "Sunday", "total": "-----", "active": "-------", "idle": "------", "productivity": "------"},
  ];

  late List<bool> _selectedRows;
  bool _isHeaderSelected = false;
  bool _isTotalSelected = false;

  @override
  void initState() {
    super.initState();
    _selectedRows = List<bool>.filled(dailyLogs.length, false);
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
              if (widget.onBackTap != null) ...[
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
                  onPressed: widget.onBackTap,
                ),
                const SizedBox(width: 8),
              ],
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.transparent,
                child: Icon(Icons.person_outline, size: 24, color: AppColors.primaryColor),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.employee?.name ?? "Jack Milson",
                    style: TTextTheme.h2Style(context).copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.employee?.email ?? "jack@gmail.com",
                    style: TTextTheme.titleSix(context).copyWith(fontSize: 12, color: AppColors.tertiaryTextColor),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),
          LayoutBuilder(
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
                                side: BorderSide(color: AppColors.borderColor, width: 1.5),
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
                      ...List.generate(dailyLogs.length, (index) {
                        return _buildDetailRow(
                          context,
                          dailyLogs[index],
                          isSelected: _selectedRows[index],
                          onChanged: (val) => _onRowSelected(index, val),
                          isTotalRow: false,
                        );
                      }),
                      _buildDetailRow(
                        context,
                        {
                          "duration": "Total",
                          "total": "48hrs",
                          "active": "34hr 45mints",
                          "idle": "5hr 15mints",
                          "productivity": "78%",
                        },
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
          ),
        ],
      ),
    );
  }

  /// -------- Extra Widget ------------///

   // Detail Row
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
              side: BorderSide(color: AppColors.borderColor, width: 1.5),
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