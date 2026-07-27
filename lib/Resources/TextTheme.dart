// Inter Thin – 100
// Inter ExtraLight – 200
// Inter Light – 300
// Inter Regular – 400
// Inter Medium – 500
// Inter SemiBold – 600
// Inter Bold – 700
// Inter ExtraBold – 800
// Inter Black – 900

import 'package:employee_monitoring_system/Resources/AppTextSizes.dart';
import 'package:employee_monitoring_system/Resources/Colors.dart';
import 'package:flutter/material.dart';



class TTextTheme{

  static TextStyle h1Style(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 26, 28, 30),fontWeight: FontWeight.w700,color: AppColors.textColor);
  }
  static TextStyle h2Style(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 16, 18, 20),fontWeight: FontWeight.w600,color: AppColors.textColor);
  }

  static TextStyle h4Style(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 17, 18, 20),fontWeight: FontWeight.w500,color: AppColors.tertiaryTextColor);
  }

  static TextStyle h7Style(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 17, 18, 20),fontWeight: FontWeight.w600,color: AppColors.primaryColor);
  }

  static TextStyle h6Style(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 17, 18, 20),fontWeight: FontWeight.w600,color: AppColors.primaryColor);
  }

  static TextStyle CancelBtn(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 17, 18, 20),fontWeight: FontWeight.w500,color: AppColors.primaryColor);
  }

  static TextStyle h3Style(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 22, 23, 24),fontWeight: FontWeight.w600,color: AppColors.textColor);
  }

  static TextStyle hLogoName(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 19, 20, 21),fontWeight: FontWeight.w600,color: AppColors.textColor);
  }

  static TextStyle pSidebar(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 16, 16, 16),fontWeight: FontWeight.w400,color: AppColors.textColor);
  }

  static TextStyle pSelectedSidebar(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 16, 16, 16),fontWeight: FontWeight.w500,color: AppColors.whiteColor);
  }

  static TextStyle timerText(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 14, 14, 14),fontWeight: FontWeight.w500,color: AppColors.primaryColor);
  }

  static TextStyle titleFive(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 14, 14, 14),fontWeight: FontWeight.w500,color: AppColors.textColor);
  }

  static TextStyle titleSeven(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 14, 14, 14),fontWeight: FontWeight.w500,color: AppColors.tertiaryTextColor);
  }

  static TextStyle titleEight(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 14, 14, 14),fontWeight: FontWeight.w600,color: AppColors.textColor);
  }

  static TextStyle InsidetimerText(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 14, 15, 16),fontWeight: FontWeight.w600,color: AppColors.textColor);
  }

  static TextStyle selectProjectText(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 14, 16, 16),fontWeight: FontWeight.w400,color: AppColors.tertiaryTextColor);
  }

  static TextStyle btnTextOne(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 11, 12, 12),fontWeight: FontWeight.w500,color: AppColors.whiteColor);
  }

  static TextStyle signoutIconText(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 14, 16, 16),fontWeight: FontWeight.w600,color: AppColors.rejectedColor);
  }

  static TextStyle titleOne(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 11, 12, 12),fontWeight: FontWeight.w500,color: AppColors.textColor);
  }
  static TextStyle titleTwo(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 11, 12, 12),fontWeight: FontWeight.w500,color: AppColors.subtextColor);
  }

  static TextStyle titleThree(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 14, 16, 16),fontWeight: FontWeight.w400,color: AppColors.textColor);
  }

  static TextStyle titleFour(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 12, 14, 14),fontWeight: FontWeight.w400,color: AppColors.textGrey);
  }

  static TextStyle TabsSelectedText(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 14, 15, 16),fontWeight: FontWeight.w600,color: AppColors.whiteColor);
  }

  static TextStyle titleSix(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 12, 14, 14),fontWeight: FontWeight.w400,color: AppColors.tertiaryTextColor);
  }

  static TextStyle FieldWriteTheText(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 14, 14, 14),fontWeight: FontWeight.w400,color: AppColors.textColor);
  }

  static TextStyle InsideAlreadyWrittenText(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 13, 14, 14),fontWeight: FontWeight.w400,color: AppColors.tertiaryTextColor);
  }

  static TextStyle ForgotPasswordText(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 13, 14, 14),fontWeight: FontWeight.w400,color: AppColors.primaryColor);
  }


  static TextStyle loginTexts(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 13, 14, 14),fontWeight: FontWeight.w600,color: AppColors.primaryColor);
  }

  static TextStyle Numbers(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 11, 12, 12),fontWeight: FontWeight.w600,color: AppColors.primaryColor);
  }

  static TextStyle upNumbers(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 12, 14, 14),fontWeight: FontWeight.w400,color: AppColors.approvedColor);
  }

  static TextStyle downNumbers(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 12, 14, 14),fontWeight: FontWeight.w400,color: AppColors.rejectedColor);
  }

  static TextStyle titleTen(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 12, 14, 16),fontWeight: FontWeight.w600,color: AppColors.primaryColor);
  }

  static TextStyle DateBreakDown(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 12, 14, 16),fontWeight: FontWeight.w500,color: AppColors.textColor);
  }

  static TextStyle TotalTimeHour(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 12, 14, 16),fontWeight: FontWeight.w500,color: AppColors.textGrey);
  }

  static TextStyle titleRegular11(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 11, 11),fontWeight: FontWeight.w400,color: AppColors.textGrey);
  }

  static TextStyle titleRegular12(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 11, 12),fontWeight: FontWeight.w400,color: AppColors.crossBackground);
  }

  static TextStyle titleRegular12Grey12(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 11, 12),fontWeight: FontWeight.w400,color: AppColors.subtextColor);
  }

  static TextStyle titleRegular12White(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 11, 12),fontWeight: FontWeight.w400,color: AppColors.whiteColor);
  }

  static TextStyle titleMedium13(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 12, 14, 14),fontWeight: FontWeight.w500,color: AppColors.textColor);
  }

  static TextStyle countryCodeText(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 10, 10, 10),fontWeight: FontWeight.w400,color: AppColors.tertiaryTextColor);
  }

  static TextStyle textFieldAboveText(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 12, 14, 14),fontWeight: FontWeight.w500,color: AppColors.tertiaryTextColor);
  }










  /// Main Functions
  static TextStyle _textStyle (
      {
        double fontSize = 12,
        required FontWeight fontWeight ,
        Color ? color,
      })  {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}