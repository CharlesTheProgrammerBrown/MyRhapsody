import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
      primaryColor: Styles.colorBackground,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      backgroundColor: Styles.colorBackground,
      accentColor: Styles.colorBlack,
      dialogTheme: DialogTheme());
}

abstract class Styles {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  static bool debugIos = false;

  //text styles
  static const TextStyle textHeadLine1 = TextStyle(
      fontSize: 34, fontWeight: FontWeight.bold, color: Styles.colorBlack);
  static const TextStyle textHeadLine2 = TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: Styles.colorBlack);
  static const TextStyle textHeadLine3 = TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: Styles.colorBlack);
  static const TextStyle textSubHeads = TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Styles.colorBlack);
  static const TextStyle textRegular = TextStyle(
      fontSize: 34, fontWeight: FontWeight.normal, color: Styles.colorBlack);
  static const TextStyle textRegularMedium = TextStyle(
      fontSize: 24, fontWeight: FontWeight.normal, color: Styles.colorBlack);
  static const TextStyle textDescriptiveItems = TextStyle(
      fontSize: 14, fontWeight: FontWeight.normal, color: Styles.colorBlack);
  static const TextStyle textDescriptiveText = TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, color: Styles.colorBlack);
  static const TextStyle textHelperText = TextStyle(
      fontSize: 11, fontWeight: FontWeight.normal, color: Styles.colorGray);

  static ButtonStyle primaryButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(colorPrimary),
    overlayColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered))
          return colorPrimary.withOpacity(0.04);
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed))
          return colorPrimary.withOpacity(0.12);
        return null; // Defer to the widget's default.
      },
    ),
  );
  static ButtonStyle secondaryButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(colorSecondary),
    overlayColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered))
          return colorSecondary.withOpacity(0.04);
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed))
          return colorSecondary.withOpacity(0.12);
        return null; // Defer to the widget's default.
      },
    ),
  );
  static ButtonStyle errorButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(colorError),
    overlayColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered))
          return colorError.withOpacity(0.04);
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed))
          return colorError.withOpacity(0.12);
        return null; // Defer to the widget's default.
      },
    ),
  );

  //color styles
  static const Color colorBlack = Color(0xff222222);
  static const Color colorGray = Color(0xff9B9B9B);
  static const Color colorGray2 = Color(0xff4f4f4f);
  static const Color colorLightGray = Color(0xC0C0C0);
  static const colorPrimary = Color(0xFF2A276C);
  static const colorSecondary = Color(0xFFDAA521);
  static const Color colorPrimary50 = Color(0xfffde7ec);
  static const Color colorPrimary100 = Color(0xfffac3cd);
  static const Color colorPrimary200 = Color(0xffe78992);
  static const Color colorPrimaryDisabled = Color(0x80da5969);
  static const Color colorPrimaryLight = Color(0xffda5969);
  static const Color colorPrimaryTransparent = Color(0x1ADB3022);

  // static const Color colorBackground = Color(0xffF9F9F9);
  static const Color colorBackground = Color(0xfffcfcfc);
  static const Color colorBackgroundDarker = Color(0xff9f9f99);
  static const Color colorWhite = Color(0xffFFFFFF);
  static const Color colorTransparent = Color(0xB3FFFFFF);
  static const Color colorError = Color(0xffF01F0E);
  static const Color colorBlackTransparent = Color(0x1A222222);
  static const Color colorSuccess = Color(0xff2AA952);
  static const Color colorSaleHot = Color(0xffDB3022);
  static const Color colorStarGold = Color(0xffFFBA49);
  static const Color colorBlue = Colors.blueAccent;

  // placeholder colors
  static const Color colorPlaceHolderBarLight = Color(0xfff3f5f8);
  static const Color colorPlaceHolderBarDark = Color(0xff94a2ab);
  static const Color colorPlaceHolderBackground = Color(0xffe0e7ec);

  static const Color colorSecondaryLight= Color(0xffFFFCF4);
}
