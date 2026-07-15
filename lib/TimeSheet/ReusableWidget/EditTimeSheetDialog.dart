import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:employee_monitoring_system/TimeSheet/ReusableWidget/CustomTimeDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';

class EditTimeSheetDialog extends StatefulWidget {
  final String initialProject;
  final String initialFromTime;
  final String initialToTime;
  final String initialReason;
  final Function(String? project, String fromTime, String toTime, String? reason) onSave;

  const EditTimeSheetDialog({
    super.key,
    this.initialProject = '',
    this.initialFromTime = '02:20pm',
    this.initialToTime = '02:20pm',
    this.initialReason = '',
    required this.onSave,
  });

  @override
  State<EditTimeSheetDialog> createState() => _EditTimeSheetDialogState();
}

class _EditTimeSheetDialogState extends State<EditTimeSheetDialog> {
  String? _selectedProject;
  String? _selectedReason;
  late TextEditingController _fromTimeController;
  late TextEditingController _toTimeController;

  bool _isProjectOpen = false;
  bool _isReasonOpen = false;

  final List<String> _projectList = ['Work Pluse', 'Soft Snip', 'Time Track'];
  final List<String> _reasonList = [
    'Forget to stop time',
    'Internet issue',
    'Server not working'
  ];

  @override
  void initState() {
    super.initState();
    _selectedProject = widget.initialProject.isNotEmpty ? widget.initialProject : null;
    _selectedReason = widget.initialReason.isNotEmpty ? widget.initialReason : null;
    _fromTimeController = TextEditingController(text: widget.initialFromTime);
    _toTimeController = TextEditingController(text: widget.initialToTime);
  }

  @override
  void dispose() {
    _fromTimeController.dispose();
    _toTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(TextEditingController controller) async {
    showDialog(
      context: context,
      builder: (context) => CustomTimePickerDialog(
        initialTime: controller.text.isNotEmpty ? controller.text : "02:20pm",
        onTimeSelected: (selectedTime) {
          setState(() {
            controller.text = selectedTime;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.whiteColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: 360,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.backgroundContainerOfNotification,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SvgPicture.asset(
                  IconString.editIcon,
                  height: 22,
                  width: 22,
                ),
              ),
              const SizedBox(height: 12),

               Text(
                 TextString.editTimeSheetTitle,
                style: TTextTheme.h2Style(context),
              ),
              const SizedBox(height: 20),

              _buildFieldLabel(TextString.projectName),
              const SizedBox(height: 6),
              _buildCustomDropdown(
                hintText: TextString.selectProject,
                selectedValue: _selectedProject,
                isOpen: _isProjectOpen,
                items: _projectList,
                onToggle: () {
                  setState(() {
                    _isProjectOpen = !_isProjectOpen;
                    if (_isProjectOpen) _isReasonOpen = false;
                  });
                },
                onSelect: (value) {
                  setState(() {
                    _selectedProject = value;
                    _isProjectOpen = false;
                  });
                },
              ),

              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFieldLabel(TextString.from),
                        const SizedBox(height: 6),
                        _buildTimeTextField(_fromTimeController),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFieldLabel(TextString.to),
                        const SizedBox(height: 6),
                        _buildTimeTextField(_toTimeController),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              _buildFieldLabel(TextString.reason),
              const SizedBox(height: 6),
              _buildCustomDropdown(
                hintText: TextString.selectReason,
                selectedValue: _selectedReason,
                isOpen: _isReasonOpen,
                items: _reasonList,
                onToggle: () {
                  setState(() {
                    _isReasonOpen = !_isReasonOpen;
                    if (_isReasonOpen) _isProjectOpen = false;
                  });
                },
                onSelect: (value) {
                  setState(() {
                    _selectedReason = value;
                    _isReasonOpen = false;
                  });
                },
              ),

              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        widget.onSave(
                          _selectedProject,
                          _fromTimeController.text,
                          _toTimeController.text,
                          _selectedReason,
                        );
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: AppColors.primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:  Text(
                        "Save",
                        style: TTextTheme.Numbers(context),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:  Text(
                        "Cancel",
                        style: TTextTheme.btnTextOne(context),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

   // Field Label
  Widget _buildFieldLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: TTextTheme.titleSeven(context),
      ),
    );
  }

  Widget _buildTimeTextField(TextEditingController controller) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: TextFormField(
        controller: controller,
        style:  TTextTheme.InsideAlreadyWrittenText(context),
        decoration: InputDecoration(
          contentPadding:  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: InputBorder.none,
          hintText: "hh:mm am/pm",
          hintStyle: TTextTheme.FieldWriteTheText(context),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.access_time_rounded,
              size: 16,
              color: AppColors.primaryColor,
            ),
            onPressed: () => _selectTime(controller),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomDropdown({
    required String hintText,
    required String? selectedValue,
    required bool isOpen,
    required List<String> items,
    required VoidCallback onToggle,
    required Function(String) onSelect,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onToggle,
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedValue ?? hintText,
                  style: TextStyle(
                    fontSize: 13,
                    color: selectedValue != null
                        ? AppColors.textColor
                        : AppColors.tertiaryTextColor,
                    fontWeight: selectedValue != null
                        ? FontWeight.w500
                        : FontWeight.normal,
                  ),
                ),
                Icon(
                  isOpen
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: AppColors.textColor,
                ),
              ],
            ),
          ),
        ),
        if (isOpen) ...[
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.borderColor),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: items.map((item) {
                final isSelected = selectedValue == item;
                return InkWell(
                  onTap: () => onSelect(item),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.backgroundContainerOfNotification
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item,
                      style: TTextTheme.FieldWriteTheText(context),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }
}