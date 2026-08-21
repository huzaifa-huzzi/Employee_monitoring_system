import 'package:employee_monitoring_system/Panel/Admin/Companies/CompaniesController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/ImageString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';


class ViewCompany extends StatelessWidget {
  final CompanyModel company;

  const ViewCompany({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    context.go('/Admin/companies');
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.borderColor.withValues(alpha: 0.5),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 18,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Companies",
                        style: TTextTheme.h3Style(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "You can see all companies here",
                        style: TTextTheme.titleFour(context).copyWith(
                          color: AppColors.tertiaryTextColor,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            _buildSectionCard(
              context: context,
              title: "General Information",
              subtitle: "Basic detail about the company",
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;
                  int crossAxisCount = width > 900 ? 3 : (width > 600 ? 2 : 1);

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildInfoContainer(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "Company Logo",
                        child: Container(
                          height: 48,
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            ImageString.companyLogo,
                            height: 42,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return SvgPicture.asset(
                                IconString.companyTable,
                                height: 36,
                              );
                            },
                          ),
                        ),
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "Company Name",
                        value: company.name,
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "Account Status",
                        value: company.accountStatus,
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "Phone Number",
                        value: "1234567-8",
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "Email Address",
                        value: company.email,
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "Email Status",
                        value: company.emailStatus,
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "Address",
                        value: "123 Hay Street",
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "Number of Employees",
                        value: company.employeesCount.toString(),
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "Joining Date",
                        value: company.joiningDate,
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            _buildSectionCard(
              context: context,
              title: "Social Links",
              subtitle: "Basic detail about the social links",
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;
                  int crossAxisCount = width > 900 ? 3 : (width > 600 ? 2 : 1);

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildSocialField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "Face Book",
                        value: "https://facebook.com",
                        svgPath: IconString.facebookIcon,
                      ),
                      _buildSocialField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "Twitter",
                        value: "https://twitter.com",
                        svgPath: IconString.xIcon,
                      ),
                      _buildSocialField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "Instagram",
                        value: "https://instagram.com",
                        svgPath: IconString.InstaIcon
                      ),
                      _buildSocialField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "LinkedIn",
                        value: "https://linkedin.com",
                        svgPath: IconString.linkedinIcon
                      ),
                      _buildSocialField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "Youtube",
                        value: "https://youtube.com",
                        svgPath: IconString.youtubeIcon
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            _buildSectionCard(
              context: context,
              title: "Subscription Information",
              subtitle: "Company subscription listed here",
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;
                  int crossAxisCount = width > 900 ? 3 : (width > 600 ? 2 : 1);

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "Plan",
                        value: company.subscription,
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "Start Date",
                        value: company.joiningDate,
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "End Date",
                        value: "4/03/2027",
                      ),
                      _buildInfoContainer(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "Payment Status",
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.borderColor.withValues(alpha: 0.6),
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: company.subscriptionStatus == 'Subscribed'
                                  ? AppColors.approvedColor
                                  : (company.subscriptionStatus == 'Overdue'
                                  ? AppColors.rejectedColor
                                  : AppColors.tertiaryTextColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              company.subscriptionStatus,
                              style: TTextTheme.SubscriptionStatusText(context).copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: "Remaining Days",
                        value: "365 Days",
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------- Extra Widget ------------- ///


    // Section Card
  Widget _buildSectionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TTextTheme.h3Style(context).copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TTextTheme.titleFour(context).copyWith(
              fontSize: 12,
              color: AppColors.tertiaryTextColor,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

   // ReadOnly Field
  Widget _buildReadOnlyField({
    required BuildContext context,
    required double width,
    required String label,
    required String value,
  }) {
    return _buildInfoContainer(
      context: context,
      width: width,
      label: label,
      child: Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
        ),
        child: Text(
          value,
          style: TTextTheme.titleFour(context).copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildSocialField({
    required BuildContext context,
    required double width,
    required String label,
    required String value,
    required String svgPath,
    Color? iconColor,
  }) {
    return _buildInfoContainer(
      context: context,
      width: width,
      label: label,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              svgPath,
              width: 18,
              height: 18,
              colorFilter: iconColor != null
                  ? ColorFilter.mode(iconColor, BlendMode.srcIn)
                  : null,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                value,
                style: TTextTheme.titleFour(context).copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoContainer({
    required BuildContext context,
    required double width,
    required String label,
    required Widget child,
  }) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TTextTheme.titleTwo(context).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.tertiaryTextColor,
            ),
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }

  double _getCardWidth(double totalWidth, int crossAxisCount) {
    if (crossAxisCount == 1) return totalWidth;
    double spacing = 16.0 * (crossAxisCount - 1);
    return (totalWidth - spacing) / crossAxisCount;
  }
}
