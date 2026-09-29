import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/themes/elevated_theme.dart';
import 'package:e_commerce/utils/themes/widget_theme.dart/app_bar_theme.dart';
import 'package:e_commerce/utils/themes/widget_theme.dart/bottom_sheet_theme.dart';
import 'package:e_commerce/utils/themes/widget_theme.dart/check_box_theme.dart';
import 'package:e_commerce/utils/themes/widget_theme.dart/chip_theme.dart';
import 'package:e_commerce/utils/themes/widget_theme.dart/outline_button_theme.dart';
import 'package:e_commerce/utils/themes/widget_theme.dart/text_form_field_theme.dart';
import 'package:e_commerce/utils/themes/widget_theme.dart/text_theme.dart';
import 'package:flutter/material.dart';

class UAppTheme {
  UAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    // brightness is status barColor
    brightness: Brightness.light,
    //primary is by default button & text links color
    primaryColor: UColors.primary,
    disabledColor: UColors.grey,
    textTheme: UTextTheme.lightTextTheme,
    chipTheme: UChipTheme.lightChipTheme,
    scaffoldBackgroundColor: UColors.white,
    appBarTheme: UAppBarTheme.lightAppBarTheme,
    checkboxTheme: UCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: UBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: UElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: UOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: UTextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    brightness: Brightness.dark,
    primaryColor: UColors.primary,
    disabledColor: UColors.grey,
    textTheme: UTextTheme.darkTextTheme,
    chipTheme: UChipTheme.darkChipTheme,
    scaffoldBackgroundColor: UColors.black,
    appBarTheme: UAppBarTheme.darkAppBarTheme,
    checkboxTheme: UCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: UBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: UElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: UOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: UTextFormFieldTheme.darkInputDecorationTheme,
  );
}
