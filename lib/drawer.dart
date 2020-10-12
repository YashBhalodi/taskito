import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskito/constant.dart';
import 'package:taskito/history.dart';
import 'package:taskito/roadmap.dart';
import 'package:taskito/themeData.dart';

class AppDrawer extends StatelessWidget {
  final SharedPreferences pref;

  const AppDrawer({Key key, this.pref}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Pallet.isabelline,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(top: 16.0,bottom: 16.0,left: 16.0,right: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Hey There!👋🏻",style: LightTheme.sectionHeadingStyle,),
                  SizedBox(height: 12.0,),
                  Text("Successfully completing your goals will reward you greatly!",style: LightTheme.sectionHeadingStyle,),
                  SizedBox(height: 16.0,),

                  Text("So far, "+ pref.getInt('globalScore').toString() + " 🌮",style: LightTheme.appBarTextStyle,),
                  SizedBox(height: 16.0,),

                  Text("Keep it up.👍🏻",style: LightTheme.sectionHeadingStyle,),
                ],
              ),
            ),
            Divider(),
            ListTile(
              title: Text("History",style: LightTheme.titleTextStyle,),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return History();
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: Text("Settings",style: LightTheme.titleTextStyle),
              onTap: (){
                Constant.showToast("Under Development");
              },
            ),
            Divider(),
            ListTile(
              title: Text("Roadmap",style: LightTheme.titleTextStyle),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return RoadMap();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
