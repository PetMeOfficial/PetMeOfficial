import 'package:flutter/material.dart';

const kSpacingUnit = 10;

const kDarkPrimaryColor = Color(0xBE0C0404);
const kDarkSecondaryColor = Color(0xFF487776);
const kDarkBlueColor = Color(0xFF487776);
const kLightPrimaryColor = Color(0xFFF5F5DC);
const kLightBlueColor = Color(0xFFF5F5DC);
const kGreenColor = Color(0xFF69F0AE);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Color(0xFFFFC107);
const kBeigeColor = Color(0xFFF5F5DC);
const kPastelBlueColor = Color(0xFF487776);

const kTitleTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

const kCaptionTextStyle = TextStyle(
  fontSize:12,
  fontWeight: FontWeight.w100,
);

const kButtonTextStyle = TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.w400,
  color: kDarkPrimaryColor,
);

final kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'SFProText',
  primaryColor: kDarkPrimaryColor,
  canvasColor: kDarkPrimaryColor,
  backgroundColor: kDarkSecondaryColor,
  accentColor: kAccentColor,
  iconTheme: ThemeData.dark().iconTheme.copyWith(
    color: kLightSecondaryColor,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    fontFamily: 'SFProText',
    bodyColor: kLightSecondaryColor,
    displayColor: kLightSecondaryColor,
  ),
);

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'SFProText',
  primaryColor: kLightPrimaryColor,
  canvasColor: kLightPrimaryColor,
  backgroundColor: kLightSecondaryColor,
  accentColor: kAccentColor,
  iconTheme: ThemeData.light().iconTheme.copyWith(
    color: kDarkSecondaryColor,
  ),
  textTheme: ThemeData.light().textTheme.apply(
    fontFamily: 'SFProText',
    bodyColor: kDarkSecondaryColor,
    displayColor: kDarkSecondaryColor,
  ),
);