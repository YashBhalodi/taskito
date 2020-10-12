import 'package:flutter/material.dart';
import 'package:taskito/constant.dart';
import 'package:taskito/themeData.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 18.0,
        width: 18.0,
        child: CircularProgressIndicator(
          backgroundColor: Pallet.satinSheenGold,
          valueColor: AlwaysStoppedAnimation(Pallet.maximumBlueGreen),
          strokeWidth: 1.0,
        ),
      ),
    );
  }
}

class SectionHead extends StatelessWidget {
  final String heading;
  final int count;

  const SectionHead({Key key, this.heading, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      width: double.maxFinite,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Text(
              heading,
              style: LightTheme.sectionHeadingStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Text(
              count.toString(),
              style: LightTheme.sectionItemCountStyle,
            ),
          )
        ],
      ),
    );
  }
}

class NothingPlanned extends StatelessWidget {
  final bool history;

  const NothingPlanned({Key key, this.history = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: double.maxFinite,
      child: Center(
          child: Text(
        history ? "Nothing Planned!" : "Nothing Planned Yet!",
        style: LightTheme.nothingPlannedTextStyle,
      )),
    );
  }
}
