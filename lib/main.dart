import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskito/constant.dart';
import 'package:taskito/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskito/themeData.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Pallet.gunmetal,
    ));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        runApp(MyApp(pref: pref,));
    });
}

class MyApp extends StatelessWidget {
    final SharedPreferences pref;

  const MyApp({Key key, this.pref}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasPrimaryFocus == false) {
          FocusScope.of(context).unfocus();
        }
      },
      child: MaterialApp(
        title: 'Taskito',
        theme: ThemeData(
          fontFamily: 'Inter',
        ),
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: Home(pref: pref,)),
      ),
    );
  }
}
