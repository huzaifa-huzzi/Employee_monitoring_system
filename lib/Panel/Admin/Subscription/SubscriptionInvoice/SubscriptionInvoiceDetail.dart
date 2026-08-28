import 'package:employee_monitoring_system/Panel/Admin/Subscription/SubscriptionController.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:employee_monitoring_system/Resources/IconString.dart';
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
                        "Thanks for your Business",
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
                "Invoices Detail",
                style: TTextTheme.titleFive(context).copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                "Your subscription detail is given below",
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
              label: "Download PDF",
            ),
            _buildOutlinedActionButton(
              context,
              icon: Icons.mail_outline_rounded,
              label: "Send Email",
            ),
            _buildOutlinedActionButton(
              context,
              icon: Icons.print_outlined,
              label: "Print",
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
        style: TTextTheme.whiteColorBtn(context)
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
              "Original For Recipient",
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
              "TAX INVOICE",
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
                    Text("Date: ", style: TTextTheme.titleSix(context).copyWith(fontSize: 11)),
                    Text("05/12/2024", style: TTextTheme.titleSix(context).copyWith(fontSize: 11, fontWeight: FontWeight.w600)),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Invoice No: ", style: TTextTheme.titleSix(context).copyWith(fontSize: 11)),
                    Text("INV 00001", style: TTextTheme.titleSix(context).copyWith(fontSize: 11, fontWeight: FontWeight.w600)),
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
              "Invoice To :",
              style: TTextTheme.titleFive(context).copyWith(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text("Walter Roberson", style: TTextTheme.titleSix(context).copyWith(fontSize: 12)),
            const SizedBox(height: 2),
            Text("92 the Avenue, Alexander Heights 6064.", style: TTextTheme.titleSix(context).copyWith(fontSize: 12)),
          ],
        );

        final payTo = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pay To :",
              style: TTextTheme.titleFive(context).copyWith(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text("Lowell H. Dominguez", style: TTextTheme.titleSix(context).copyWith(fontSize: 12)),
            const SizedBox(height: 2),
            Text("84 Spilman Street, London United King", style: TTextTheme.titleSix(context).copyWith(fontSize: 12)),
            const SizedBox(height: 2),
            Text("domlowell@gmail.com", style: TTextTheme.titleSix(context).copyWith(fontSize: 12)),
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
                Text("Item", style: TTextTheme.titleFive(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
                Text("Price", style: TTextTheme.titleFive(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
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
                    Text("Active Vehicle", style: TTextTheme.titleSix(context).copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Text("Rate per Car", style: TTextTheme.titleSix(context).copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("20.00", style: TTextTheme.titleFive(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text("\$8.00", style: TTextTheme.titleFive(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
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
                    Text("Important Note:", style: TTextTheme.titleSix(context).copyWith(fontSize: 11, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 2),
                    Text(
                      "Payments are verified after receipt. Subscription renewals are activated once the payment has been successfully confirmed.",
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
                        Text("Taxable Amount ", style: TTextTheme.titleFive(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
                        Text("\$20.00", style: TTextTheme.titleFive(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
                      children: [
                        Text("Discount 0% ", style: TTextTheme.titleFive(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
                        Text("+ \$0.00", style: TTextTheme.titleFive(context).copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
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
                  "Total Items / Qty : 4 / 4.00",
                  style: TTextTheme.titleSix(context).copyWith(fontSize: 11),
                );

                final totalText = Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Total", style: TTextTheme.titleFive(context).copyWith(fontSize: 15, fontWeight: FontWeight.bold)),
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
                    "Total amount ( in words): One Hundred Eighty Dollars Only",
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
              "Payment Info:",
              style: TTextTheme.titleFive(context).copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text("Debit Card : 465 *************645", style: TTextTheme.titleSix(context).copyWith(fontSize: 11)),
            const SizedBox(height: 2),
            Text("Amount : ${item?.pricing ?? '\$1,815'}", style: TTextTheme.titleSix(context).copyWith(fontSize: 11)),
          ],
        );

        final signature = Column(
          crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text("From Soft Snipt", style: TTextTheme.titleSix(context).copyWith(fontSize: 11)),
            const SizedBox(height: 4),
            Text(
              "James Paulo",
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
          "Terms & Conditions :",
          style: TTextTheme.titleFive(context).copyWith(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "1. Subscription fees are non-refundable once payment has been successfully verified and the subscription has been activated.",
          style: TTextTheme.titleSix(context).copyWith(fontSize: 11, height: 1.4),
        ),
        const SizedBox(height: 4),
        Text(
          "2. Customers are responsible for ensuring all billing information and payment references are accurate before submitting a payment.",
          style: TTextTheme.titleSix(context).copyWith(fontSize: 11, height: 1.4),
        ),
      ],
    );
  }
}
