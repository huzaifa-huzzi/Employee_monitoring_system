import 'package:employee_monitoring_system/Panel/Admin/Companies/CompaniesController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/ImageString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
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
                        TextString.adminCompanyTitle,
                        style: TTextTheme.h3Style(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        TextString.adminCompanySubtitle,
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
              title:TextString.adminCompanyGeneral,
              subtitle:TextString.adminCompanyGeneralSubtitle ,
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
                        label: TextString.adminCompanyGeneralOne,
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
                        label:TextString.adminCompanyGeneralTwo ,
                        value: company.name,
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label:TextString.adminCompanyGeneralThree,
                        value: company.accountStatus,
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label:TextString.adminCompanyGeneralFour ,
                        value: "1234567-8",
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label:TextString.adminCompanyGeneralFive ,
                        value: company.email,
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label:TextString.adminCompanyGeneralSix ,
                        value: company.emailStatus,
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label:TextString.adminCompanyGeneralSeven ,
                        value:TextString.adminCompanyGeneralEight ,
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label:TextString.adminCompanyGeneralNine ,
                        value: company.employeesCount.toString(),
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label:TextString.adminCompanyGeneralTen ,
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
              title: TextString.adminCompanySocial ,
              subtitle:TextString.adminCompanySocialSubtitle ,
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
                        label:TextString.adminCompanySocialOne ,
                        value:TextString.adminCompanySocialTwo,
                        svgPath: IconString.facebookIcon,
                      ),
                      _buildSocialField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label:TextString.adminCompanySocialThree,
                        value:TextString.adminCompanySocialFour ,
                        svgPath: IconString.xIcon,
                      ),
                      _buildSocialField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label:TextString.adminCompanySocialFive ,
                        value:TextString.adminCompanySocialSix ,
                        svgPath: IconString.InstaIcon
                      ),
                      _buildSocialField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label:TextString.adminCompanySocialSeven ,
                        value:TextString.adminCompanySocialEight ,
                        svgPath: IconString.linkedinIcon
                      ),
                      _buildSocialField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label:TextString.adminCompanySocialNine ,
                        value:TextString.adminCompanySocialTen ,
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
              title: TextString.adminCompanySubscriptionTitle ,
              subtitle:TextString.adminCompanySubscriptionSubtitle ,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;
                  int crossAxisCount = width > 900 ?
                  3 : (width > 600 ? 2 : 1);

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label:TextString.adminCompanySubscriptionOne ,
                        value: company.subscription,
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: TextString.adminCompanySubscriptionTwo,
                        value: company.joiningDate,
                      ),
                      _buildReadOnlyField(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label:TextString.adminCompanySubscriptionThree ,
                        value:TextString.adminCompanySubscriptionFour ,
                      ),
                      _buildInfoContainer(
                        context: context,
                        width: _getCardWidth(width, crossAxisCount),
                        label: TextString.adminCompanyPaymentTitle,
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
                        label: TextString.adminCompanyPaymentOne ,
                        value: TextString.adminCompanyPaymentTwo ,
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
