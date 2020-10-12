import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskito/classes.dart';
import 'package:taskito/dummyAds.dart';
import 'package:vibration/vibration.dart';

class Constant {
  static get appName => "Taskito";

  static get dateFormatter => DateFormat('yyyy-MM-dd');

  static get textFieldPadding => EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0);

  static get dialogShape => RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      );

  static get buttonShape => RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      );

  static get dummyTask => Task(
        title: "Dummy Task Title",
        date: DateTime.now(),
        level: 3,
        note: "This is extra note for a task.\nSecond line for testing purpose.",
        done: false,
      );

  static void showDummyAds(context) {
    showDialog(
        context: context,
        builder: (context) {
          return DummyAds();
        });
  }

  static void updateGlobalScore(
      {int level, bool dailyAccomplishment, bool deletion, bool setUp}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int increment, curScore;
    if (dailyAccomplishment != null) {
      increment = 5;
      curScore = pref.getInt('globalScore');
    } else if (deletion != null) {
      increment = -3;
      curScore = pref.getInt('globalScore');
    } else if (setUp != null) {
      increment = 10;
      curScore = 0;
    } else {
      increment = level;
      curScore = pref.getInt('globalScore');
    }
    String msg =
        increment < 0 ? "Penalty of ${increment.abs()} 🌮" : "Rewards $increment 🌮 claimed";
    pref.setInt('globalScore', curScore + increment);
      showToast(msg);
      defaultVibrate();
  }

  static void showToast(String msg) {
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Pallet.gunmetal,
          textColor: Pallet.cultured,
          fontSize: 16.0,
      );
  }

  static void defaultVibrate() async {
      if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 300);
      }
  }
}

class Pallet {
  static get isabelline => Color(0xfff5f0ed);

  static get gunmetal => Color(0xff0b3744);

  static get indianRed => Color(0xffd65e58);

  static get maximumBlueGreen => Color(0xff29b3c1);

  static get satinSheenGold => Color(0xffcba135);

  static get cultured => Color(0xfff5f5f5);

  static get midnightGreenEagleGreen => Color(0xff1E3E90);

  static get pacificBlue => Color(0xff01acbd);

  static get tartOrange => Color(0xfff45c5f);

  static get battleshipGrey => Color(0xff848786);
}
