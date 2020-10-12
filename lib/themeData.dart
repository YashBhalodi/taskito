import 'package:flutter/material.dart';
import 'package:taskito/constant.dart';

class LightTheme {
  static get appBarTextStyle => TextStyle(
        fontFamily: 'ValeraRound',
        color: Pallet.midnightGreenEagleGreen,
        fontWeight: FontWeight.w600,
      fontSize: 24.0,
      );

  static get appBarColor => Pallet.isabelline;

  static get scaffoldBackgroundColor => Pallet.cultured;

  static get sectionHeadingStyle => TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Pallet.midnightGreenEagleGreen);
  static get sectionItemCountStyle => TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700,color: Pallet.midnightGreenEagleGreen);

  static get nothingPlannedTextStyle => TextStyle(fontSize: 20.0,fontWeight: FontWeight.w400,color: Pallet.battleshipGrey);
  static get headingTextStyle =>
      TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Pallet.maximumBlueGreen);

  static get inputNoteTextStyle => TextStyle(fontSize: 18.0,color: Pallet.midnightGreenEagleGreen,fontWeight: FontWeight.w500,);

  static get noteTextStyle => TextStyle(fontSize: 18.0,color: Pallet.gunmetal,fontWeight: FontWeight.w500,);

  static get inputTitleTextStyle => TextStyle(fontSize: 20.0,color: Pallet.midnightGreenEagleGreen,fontWeight: FontWeight.w500,);

  static get titleTextStyle => TextStyle(fontSize: 20.0,color: Pallet.gunmetal,fontWeight: FontWeight.w500,);

  static get taskTileBackgroundColor => Pallet.isabelline;

  static get doneTaskTileBackgroundColor => Pallet.battleshipGrey;

  static get formFieldFillColor => Pallet.isabelline;

  static get dummyAdTextStyle => TextStyle(fontSize: 20.0,color: Pallet.midnightGreenEagleGreen);
  static get primaryCTATextColor => Pallet.cultured;
  static get primaryCTATextStyle => TextStyle(fontWeight: FontWeight.w500,color: primaryCTATextColor,fontSize: 22.0,);
  static get primaryCTAButtonColor => Pallet.midnightGreenEagleGreen;
  static get checkBoxActiveColor => Pallet.isabelline;
  static get checkBoxCheckColor => Pallet.gunmetal;
}
