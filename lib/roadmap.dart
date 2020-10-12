import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskito/themeData.dart';

class RoadMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: LightTheme.scaffoldBackgroundColor,
        appBar: AppBar(
            centerTitle: true,
            elevation: 15.0,
            backgroundColor: LightTheme.appBarColor,
            title: Text(
                "Roadmap",
                style: LightTheme.appBarTextStyle,
            ),
            automaticallyImplyLeading: true,
            iconTheme: new IconThemeData(color: LightTheme.primaryCTAButtonColor),
        ),
        body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Text("1.Notificatios",style: LightTheme.sectionHeadingStyle,),
                    SizedBox(height: 12.0,),
                    Text("\t\tLocal notification at the end of the day to remind usersof any incomplete tasks.\n\n\t\tIf there are no incomplete task left for the day, user should be rewarded with 🌮s.",style: LightTheme.sectionHeadingStyle,),
                    Divider(),
                    Text("2.Search",style: LightTheme.sectionHeadingStyle,),
                    SizedBox(height: 12.0,),
                    Text("\tSearch by keywords and search by date needs to implemented.",style: LightTheme.sectionHeadingStyle,),
                    Spacer(),
                    Text("About:",style: LightTheme.sectionHeadingStyle,),
                    Text("\t\tDeveloper: Yash Bhalodi\n\t\tEmail: yashbhalodi07@gmail.com\n\t\tGitHub: @YashBhalodi",style: LightTheme.sectionHeadingStyle,),
                ],
            ),
        ),
    );
  }
}
