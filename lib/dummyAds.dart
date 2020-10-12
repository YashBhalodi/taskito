import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskito/constant.dart';
import 'package:taskito/themeData.dart';

class DummyAds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: Constant.dialogShape,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 16.0,
        ),
        child: Text(
          "Penalty Ad\n\nTap anywhere outside to dissmiss.",
          style: LightTheme.dummyAdTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
