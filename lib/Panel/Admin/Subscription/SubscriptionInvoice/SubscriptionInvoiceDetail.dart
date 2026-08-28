import 'package:employee_monitoring_system/Panel/Admin/Subscription/SubscriptionController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
import 'package:employee_monitoring_system/Resources/TextString.dart';
import 'package:employee_monitoring_system/Resources/TextTheme.dart';
import 'package:flutter/material.dart';


class SubscriptionInvoiceDetail extends StatelessWidget {
  final SubscriptionItem? item;

  const SubscriptionInvoiceDetail({super.key, this.item});

  // Logo
  static Widget buildLogo(BuildContext context, bool isCollapsed) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isCollapsed ? 0 : 24,
        vertical: 20,
      ),
      child: SizedBox(
        height: 30,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(IconString.logoIcon),
              if (!isCollapsed) ...[
                const SizedBox(width: 12),
                Text(
                  "SoftSnip",
                  style: TTextTheme.hLogoName(context),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmallScreen = screenWidth < 360;

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isVerySmallScreen ? 12.0 : 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(isVerySmallScreen ? 14.0 : 28.0),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: AppColors.borderColor.withValues(alpha: 0.5), thickness: 1),
                    const SizedBox(height: 16),
                    _buildTopActions(context),
                    const SizedBox(height: 20),
                    _buildInvoiceBranding(context),
                    const SizedBox(height: 16),
                    Divider(color: AppColors.borderColor.withValues(alpha: 0.6), thickness: 1),
                    const SizedBox(height: 20),
                    _buildBillingDetails(context),
                    const SizedBox(height: 24),
                    _buildInvoiceTable(context),
                    const SizedBox(height: 28),
                    _buildPaymentAndSignature(context),
                    const SizedBox(height: 24),
                    _buildTermsAndConditions(context),
                    const SizedBox(height: 24),
                    Divider(color: AppColors.borderColor.withValues(alpha: 0.6), thickness: 1),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                       TextString.adminSubscriptionInvoiceThanks,
                        style: TTextTheme.titleSix(context).copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ----------- Extra Widget -------------- ///

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
                TextString.adminSubscriptionTitleTwo,
                style: TTextTheme.titleFive(context).copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                TextString.adminSubscriptionSubtitleTwo,
                style: TTextTheme.titleSix(context).copyWith(
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

  // Action Button
  Widget _buildTopActions(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        final buttons = Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: isMobile ? WrapAlignment.start : WrapAlignment.end,
          children: [
            _buildOutlinedActionButton(
              context,
              icon: Icons.picture_as_pdf_outlined,
              label: TextString.adminSubscriptionPdf,
            ),
            _buildOutlinedActionButton(
              context,
              icon: Icons.mail_outline_rounded,
              label: TextString.adminSubscriptionEmail ,
            ),
            _buildOutlinedActionButton(
              context,
              icon: Icons.print_outlined,
              label: TextString.adminSubscriptionPrint ,
            ),
          ],
        );

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPaidBadge(context),
              const SizedBox(height: 12),
              buttons,
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildPaidBadge(context),
            const SizedBox(width: 12),
            buttons,
          ],
        );
      },
    );
  }

  Widget _buildPaidBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.approvedColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        "Paid",
        style: TTextTheme.whiteColorBtn(context),
      ),
    );
  }

  // Outline Action Button
  Widget _buildOutlinedActionButton(BuildContext context, {required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TTextTheme.titleFive(context).copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Invoice Branding
  Widget _buildInvoiceBranding(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 500;

        final leftSide = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.translate(
              offset: const Offset(-24, -20),
              child: buildLogo(context, false),
            ),
            Text(
             TextString.adminSubscriptionOriginalRecipient,
              style: TTextTheme.titleSix(context).copyWith(
                fontSize: 11,
              ),
            ),
          ],
        );

        final rightSide = Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(
              TextString.adminSubscriptionInvoice,
              style: TTextTheme.titleFive(context).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 6,
              runSpacing: 4,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(TextString.adminSubscriptionDate, style: TTextTheme.titleSix(context).copyWith(fontSize: 11)),
                    Text(TextString.adminSubscriptionDateTwo, style: TTextTheme.titleSix(context).copyWith(fontSize: 11, fontWeight: FontWeight.w600)),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(TextString.adminSubscriptionInvoiceNo, style: TTextTheme.titleSix(context).copyWith(fontSize: 11)),
                    Text(TextString.adminSubscriptionInvoiceNoMain, style: TTextTheme.titleSix(context).copyWith(fontSize: 11, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ],
        );

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              leftSide,
              const SizedBox(height: 12),
              rightSide,
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            leftSide,
            rightSide,
          ],
        );
      },
    );
  }

  // Billing Address Block
  Widget _buildBillingDetails(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        final invoiceTo = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextString.adminSubscriptionInvoiceTo,
              style: TTextTheme.titleFive(context).copyWith(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(TextString.adminSubscriptionName, style: TTextTheme.titleSix(context).copyWith(fontSize: 12)),
            const SizedBox(height: 2),
            Text(TextString.adminSubscriptionAddress, style: TTextTheme.titleSix(context).copyWith(fontSize: 12)),
          ],
        );

        final payTo = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextString.adminSubscriptionPayto,
              style: TTextTheme.titleFive(context).copyWith(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(TextString.adminSubscriptionpayName, style: TTextTheme.titleSix(context).copyWith(fontSize: 12)),
            const SizedBox(height: 2),
            Text(TextString.adminSubscriptionpayAddress, style: TTextTheme.titleSix(context).copyWith(fontSize: 12)),
            const SizedBox(height: 2),
            Text(TextString.adminSubscriptionpayEmail, style: TTextTheme.titleSix(context).copyWith(fontSize: 12)),
          ],
        );

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              invoiceTo,
              const SizedBox(height: 16),
              payTo,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: invoiceTo),
            const SizedBox(width: 24),
            Expanded(child: payTo),
          ],
        );
      },
    );
  }

  // Invoice Table
  Widget _buildInvoiceTable(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor.withValues(alpha: 0.6)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.backgroundOfScreenColor.withValues(alpha: 0.5),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(TextString.adminSubscriptionITem, style: TTextTheme.titleFive(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
                Text(TextString.adminSubscriptionPrice, style: TTextTheme.titleFive(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.borderColor),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(TextString.adminSubscriptionActiveEmployee, style: TTextTheme.titleSix(context).copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Text(TextString.adminSubscriptionActiveEmployeeSubtitle, style: TTextTheme.titleSix(context).copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(TextString.adminSubscriptionActiveEmployee, style: TTextTheme.titleFive(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(TextString.adminSubscriptionActiveEmployeeTwo, style: TTextTheme.titleFive(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.borderColor),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 450;

                Widget noteWidget = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(TextString.adminSubscriptionImportant, style: TTextTheme.titleSix(context).copyWith(fontSize: 11, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 2),
                    Text(
                      TextString.adminSubscriptionImportantSubtitle,
                      style: TTextTheme.titleSix(context).copyWith(fontSize: 11, height: 1.3),
                    ),
                  ],
                );

                Widget taxWidget = Column(
                  crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
                      children: [
                        Text(TextString.adminSubscriptionTaxable, style: TTextTheme.titleFive(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
                        Text(TextString.adminSubscriptionTaxableSubtitle, style: TTextTheme.titleFive(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
                      children: [
                        Text(TextString.adminSubscriptionDiscount, style: TTextTheme.titleFive(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
                        Text(TextString.adminSubscriptionDiscountSubtitle, style: TTextTheme.titleFive(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                );

                if (isMobile) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      noteWidget,
                      const SizedBox(height: 12),
                      taxWidget,
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: noteWidget),
                    const SizedBox(width: 8),
                    taxWidget,
                  ],
                );
              },
            ),
          ),
          Divider(height: 1, color: AppColors.borderColor),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.backgroundOfScreenColor,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isSmall = constraints.maxWidth < 280;

                final qtyText = Text(
                  TextString.adminSubscriptionTotalItems,
                  style: TTextTheme.titleSix(context).copyWith(fontSize: 11),
                );

                final totalText = Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(TextString.adminSubscriptionTotal, style: TTextTheme.titleFive(context).copyWith(fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 12),
                    Text(item?.pricing ?? "\$180.00", style: TTextTheme.titleFive(context).copyWith(fontSize: 15, fontWeight: FontWeight.bold)),
                  ],
                );

                if (isSmall) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      qtyText,
                      const SizedBox(height: 8),
                      totalText,
                    ],
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: qtyText),
                    totalText,
                  ],
                );
              },
            ),
          ),
          Divider(height: 1, color: AppColors.borderColor),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                   TextString.adminSubscriptionTotalAmount,
                    style: TTextTheme.titleSix(context).copyWith(fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Payment and Signature
  Widget _buildPaymentAndSignature(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 500;

        final paymentInfo = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextString.adminPaymentInfo,
              style: TTextTheme.titleFive(context).copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(TextString.adminPaymentInfoSubtitle, style: TTextTheme.titleSix(context).copyWith(fontSize: 11)),
            const SizedBox(height: 2),
            Text("Amount : ${item?.pricing ?? '\$180.00'}", style: TTextTheme.titleSix(context).copyWith(fontSize: 11)),
          ],
        );

        final signature = Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(TextString.adminPaymentSoftSnip, style: TTextTheme.titleSix(context).copyWith(fontSize: 11)),
            const SizedBox(height: 4),
            Text(
              TextString.adminSubscriptionSignature,
              style: TextStyle(
                fontFamily: 'Cursive',
                fontSize: 24,
                color: AppColors.textColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        );

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              paymentInfo,
              const SizedBox(height: 16),
              signature,
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            paymentInfo,
            signature,
          ],
        );
      },
    );
  }

  // Terms & Conditions Block
  Widget _buildTermsAndConditions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TextString.adminSubscriptionTerms,
          style: TTextTheme.titleFive(context).copyWith(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          TextString.adminSubscriptionTermsOne,
          style: TTextTheme.titleSix(context).copyWith(fontSize: 11, height: 1.4),
        ),
        const SizedBox(height: 4),
        Text(
          TextString.adminSubscriptionTermsTwo,
          style: TTextTheme.titleSix(context).copyWith(fontSize: 11, height: 1.4),
        ),
      ],
    );
  }
}
