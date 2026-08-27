import 'package:employee_monitoring_system/Panel/Admin/Subscription/SubscriptionController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/ImageString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';


class SubscriptionView extends StatelessWidget {
  final SubscriptionItem? item;

  const SubscriptionView({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              _buildGeneralInformationCard(context),
              const SizedBox(height: 20),
              _buildSubscriptionInformationCard(context),
            ],
          ),
        ),
      ),
    );
  }

   /// ---------- Extra Widget ----------- ///

  // Header
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: const Icon(Icons.arrow_back, size: 18, color: AppColors.textColor),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Subscription",
                style: TTextTheme.titleFive(context).copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                "Your subscription detail is given below",
                style: TTextTheme.titleSix(context).copyWith(
                  color: AppColors.subtextColor,
                  fontSize: 12,
                ),
                softWrap: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // General Info Card
  Widget _buildGeneralInformationCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "General Information",
            style: TTextTheme.titleFive(context).copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Basic detail about the company",
            style: TTextTheme.titleSix(context).copyWith(
              color: AppColors.subtextColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 20),

          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 700;
              final double fieldWidth = isMobile ? constraints.maxWidth : (constraints.maxWidth - 32) / 3;

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: fieldWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel(context, "Company Logo"),
                        const SizedBox(height: 12),
                        Image.asset(
                          ImageString.companyLogo,
                          height: 42,
                          fit: BoxFit.contain,
                          alignment: Alignment.centerLeft,
                        ),
                      ],
                    ),
                  ),
                  _buildReadOnlyField(context, "Company Name", item?.companyName ?? "Soft Snip", fieldWidth),
                  _buildReadOnlyField(context, "Account Status", "Active", fieldWidth),
                  _buildReadOnlyField(context, "Phone Number", "1234567-8", fieldWidth),
                  _buildReadOnlyField(context, "Email Address", "aussie@gmail.com", fieldWidth),
                  _buildReadOnlyField(context, "Email Status", "Verified", fieldWidth),
                  _buildReadOnlyField(context, "Address", "123 Hay Street", fieldWidth),
                  _buildReadOnlyField(context, "Number of Employees", "258", fieldWidth),
                  _buildReadOnlyField(context, "Joining Date", item?.startDate ?? "4/03/2026", fieldWidth),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Subscription Info Card
  Widget _buildSubscriptionInformationCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Subscription Information",
            style: TTextTheme.titleFive(context).copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Company subscription listed here",
            style: TTextTheme.titleSix(context).copyWith(
              color: AppColors.subtextColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 20),

          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 700;
              final double fieldWidth = isMobile ? constraints.maxWidth : (constraints.maxWidth - 32) / 3;

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _buildReadOnlyField(context, "Plan", item?.plan ?? "Monthly", fieldWidth),
                  _buildReadOnlyField(context, "Start Date", item?.startDate ?? "4/03/2026", fieldWidth),
                  _buildReadOnlyField(context, "End Date", item?.endDate ?? "4/03/2027", fieldWidth),

                  SizedBox(
                    width: fieldWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel(context, "Payment Status"),
                        const SizedBox(height: 8),
                        Container(
                          height: 48,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.borderColor),
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.whiteColor,
                          ),
                          alignment: Alignment.centerLeft,
                          child: _buildStatusBadge(context, item?.status ?? "Active"),
                        ),
                      ],
                    ),
                  ),

                  _buildReadOnlyField(context, "Remaining Days", "365 Days", fieldWidth),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
  Widget _buildLabel(BuildContext context, String label) {
    return Text(
      label,
      style: TTextTheme.titleSix(context).copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.subtextColor,
      ),
    );
  }

  // Read Only Field
  Widget _buildReadOnlyField(BuildContext context, String label, String value, double width) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(context, label),
          const SizedBox(height: 8),
          SizedBox(
            height: 48,
            child: TextField(
              cursorColor: AppColors.textColor,
              controller: TextEditingController(text: value),
              readOnly: true,
              enableInteractiveSelection: false,
              style: TTextTheme.titleFive(context).copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                filled: true,
                fillColor: AppColors.whiteColor,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.borderColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

   // Status Badge
  Widget _buildStatusBadge(BuildContext context, String status) {
    Color bg;
    Color text = AppColors.whiteColor;
    String displayStatus;

    switch (status.toLowerCase()) {
      case 'active':
      case 'subscribed':
        bg = AppColors.approvedColor;
        displayStatus = "Subscribed";
        break;
      case 'suspended':
        bg = AppColors.rejectedColor;
        displayStatus = "Expired";
      case 'expired':
        bg = AppColors.tertiaryTextColor;
        displayStatus = "Expired";
        break;
      default:
        bg = AppColors.primaryColor;
        displayStatus = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        displayStatus,
        style: TTextTheme.btnTextOne(context).copyWith(
          color: text,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
