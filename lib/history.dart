import 'package:flutter/material.dart';
import 'package:taskito/classes.dart';
import 'package:taskito/constant.dart';
import 'package:taskito/db.dart';
import 'package:taskito/taskTile.dart';
import 'package:taskito/themeData.dart';
import 'package:taskito/utilityWidgets.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool loading = true;
  List<List<Task>> tasks = [];
  List<String> dates = [];

  Future<void> loadTasks() async {
    setState(() {
      loading = true;
    });
    var db = new DBHelper();
    for (int i = 7; i >= 0; i--) {
      DateTime curDate = DateTime.now().subtract(Duration(days: i));
      var tl = await db.getTask(curDate);
      tasks.add(tl);
      dates.add(Constant.dateFormatter.format(curDate));
    }
    tasks = tasks.reversed.toList();
    dates = dates.reversed.toList();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    loadTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 15.0,
        backgroundColor: LightTheme.appBarColor,
        title: Text(
          "History",
          style: LightTheme.appBarTextStyle,
        ),
        automaticallyImplyLeading: true,
        iconTheme: new IconThemeData(color: LightTheme.primaryCTAButtonColor),
      ),
      body: loading
          ? CustomCircularProgressIndicator()
          : ListView.builder(
              shrinkWrap: true,
              itemBuilder: (c, i) {
                return DayTaskList(
                  taskList: tasks[i],
                  day: dates[i],
                  refreshList: loadTasks,
                );
              },
              itemCount: tasks.length,
            ),
    );
  }
}

class DayTaskList extends StatelessWidget {
  final List<Task> taskList;
  final String day;
  final Function refreshList;

  const DayTaskList({Key key, this.taskList, this.day, this.refreshList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        SectionHead(
          heading: day,
          count: taskList.length,
        ),
        taskList.length > 0
            ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: taskList.length,
                itemBuilder: (c, i) {
                  return TaskTile(
                    task: taskList[i],
                    refreshList: refreshList,
                  );
                },
              )
            : NothingPlanned(history: true,),
      ],
    );
  }
}
