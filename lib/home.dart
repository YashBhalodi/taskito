import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskito/addTaskButton.dart';
import 'package:taskito/classes.dart';
import 'package:taskito/constant.dart';
import 'package:taskito/drawer.dart';
import 'package:taskito/searchTask.dart';
import 'package:taskito/themeData.dart';
import 'package:taskito/utilityWidgets.dart';

import 'db.dart';

class Home extends StatefulWidget {
  final SharedPreferences pref;

  Home({Key key, this.pref}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> todayList = [];
  List<Task> tomorrowList = [];
  List<Task> notDoneTodayList = [];
  List<Task> notDoneTomorrowList = [];
  bool loading = true;
  bool filterView = false;
  bool firstLaunch;

  Future<void> loadTasks() async {
    setState(() {
      loading = true;
    });
    var db = new DBHelper();
    todayList = await db.getTask(DateTime.now());
    tomorrowList = await db.getTask(DateTime.now().add(Duration(days: 1)));
    filterTask();
    setState(() {
      loading = false;
    });
  }

  void filterTask() {
    notDoneTodayList.clear();
    notDoneTomorrowList.clear();
    todayList.forEach((t) {
      if (!t.done) {
        notDoneTodayList.add(t);
      }
    });
    tomorrowList.forEach((t) {
      if (!t.done) {
        notDoneTomorrowList.add(t);
      }
    });
  }

  @override
  void initState() {
    loadTasks();
    firstLaunch = widget.pref.getBool('firstLaunch');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (firstLaunch == null || firstLaunch == true) {
      Constant.updateGlobalScore(setUp: true);
      widget.pref.setBool('firstLaunch', false);
      firstLaunch = false;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 15.0,
        backgroundColor: LightTheme.appBarColor,
        title: Text(
          Constant.appName,
          style: LightTheme.appBarTextStyle,
        ),
        actions: <Widget>[
          Tooltip(
            message: filterView ? "Show All" : "Show Incomplete",
            child: IconButton(
              icon: Icon(
                filterView ? Icons.filter : Icons.filter_none,
                color: LightTheme.primaryCTAButtonColor,
              ),
              onPressed: () async {
                Constant.showToast(filterView ? "Showing All Task" : "Showing Incomplete Task");
                await loadTasks();
                setState(() {
                  filterView = !filterView;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.search, color: LightTheme.primaryCTAButtonColor),
            onPressed: () {
              Constant.showToast("Under Development");
            },
          )
        ],
        iconTheme: new IconThemeData(color: LightTheme.primaryCTAButtonColor),
      ),
      backgroundColor: LightTheme.scaffoldBackgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: loading
                ? CustomCircularProgressIndicator()
                : filterView
                    ? Scrollbar(
                        child: TaskLists(
                          todayList: notDoneTodayList,
                          tomorrowList: notDoneTomorrowList,
                          refreshList: loadTasks,
                        ),
                      )
                    : Scrollbar(
                        child: TaskLists(
                          todayList: todayList,
                          tomorrowList: tomorrowList,
                          refreshList: loadTasks,
                        ),
                      ),
          ),
          AddTaskButton(
            refreshList: loadTasks,
          ),
        ],
      ),
      drawer: AppDrawer(
        pref: widget.pref,
      ),
    );
  }
}
