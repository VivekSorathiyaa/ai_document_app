import 'package:flutter/material.dart';

const Color lightBlackColor = Color(0xff2B2C33);
const Color bgBlackColor = Color(0xff191C21);
const Color tableHeaderColor = Color(0xff1D2026);
const Color tableRowColor = Color(0xff292D34);
const Color tableBorderColor = Color(0xff414752);
const Color tableButtonColor = Color(0xff414752);
const Color tableTextColor = Color(0xffE2E2E2);
const Color orangeColor = Color(0xffF66A4B);
const Color purpleColor = Color(0xff6B53EE);
const Color primaryColor = Color(0xff6B53EE);
const Color purpleBorderColor = Color(0xff6E4CF7);
const Color blueColor = Color(0xff3E66DF);
const Color greyColor = Color(0xff868686);
const Color hintGreyColor = Color(0xFFBFBFBF);
const Color textGreyColor = Color(0xFF828282);
const Color dividerColor = Color(0xFF4D4D4D);
const Color darkDividerColor = Color(0xFF282F3A);
const Color yellowColor = Color(0xFFFFC700);
const Color bgContainColor = Color(0xFF292D34);
const Color greenColor = Color(0xFF49C02B);

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;

const MaterialColor primaryWhite = MaterialColor(
  _whitePrimaryValue,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(_whitePrimaryValue),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);
const int _whitePrimaryValue = 0xFFFFFFFF;
