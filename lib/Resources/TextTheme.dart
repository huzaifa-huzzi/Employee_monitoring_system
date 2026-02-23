// Inter Thin – 100
// Inter ExtraLight – 200
// Inter Light – 300
// Inter Regular – 400
// Inter Medium – 500
// Inter SemiBold – 600
// Inter Bold – 700
// Inter ExtraBold – 800
// Inter Black – 900

import 'dart:ui';
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

  static TextStyle hLogoName(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 19, 20, 21),fontWeight: FontWeight.w600,color: AppColors.textColor);
  }

  static TextStyle pSidebar(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 16, 16, 16),fontWeight: FontWeight.w400,color: AppColors.textColor);
  }

  static TextStyle pSelectedSidebar(BuildContext context){
    return _textStyle(fontSize:AppTextSizes.size(context, 16, 16, 16),fontWeight: FontWeight.w500,color: AppColors.whiteColor);
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