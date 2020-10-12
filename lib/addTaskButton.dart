import 'package:flutter/material.dart';
import 'package:taskito/addTaskSheet.dart';
import 'package:taskito/classes.dart';
import 'package:taskito/constant.dart';
import 'package:taskito/taskTile.dart';
import 'package:taskito/themeData.dart';
import 'package:taskito/utilityWidgets.dart';

class AddTaskButton extends StatelessWidget {
    final Function refreshList;

    const AddTaskButton({Key key, this.refreshList}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return SizedBox(
            height: 64.0,
            width: double.maxFinite,
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                    ),
                ),
                color: LightTheme.primaryCTAButtonColor,
                onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isDismissible: true,
                        builder: (context) {
                            return Container(
                                constraints: BoxConstraints.loose(
                                    Size(
                                        MediaQuery.of(context).size.width,
                                        MediaQuery.of(context).size.height * 0.65 +
                                            MediaQuery.of(context).viewInsets.bottom,
                                    ),
                                ),
                                child: AddTaskSheet(refreshList: refreshList,),
                            );
                        },
                        shape: Constant.buttonShape,
                        backgroundColor: Colors.grey[200],
                        isScrollControlled: true,
                        elevation: 10.0,
                    );
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        Icon(
                            Icons.add,
                            size: 22.0,
                            color: LightTheme.primaryCTATextColor,
                        ),
                        SizedBox(
                            width: 8.0,
                        ),
                        Text(
                            "New Task",
                            style: LightTheme.primaryCTATextStyle,
                        ),
                    ],
                ),
            ),
        );
    }
}

class TaskLists extends StatelessWidget {
    final List<Task> todayList;
    final List<Task> tomorrowList;
    final Function refreshList;

    const TaskLists({Key key, this.todayList, this.tomorrowList, this.refreshList})
        : super(key: key);

    @override
    Widget build(BuildContext context) {
        return ListView(
            shrinkWrap: true,
            children: <Widget>[
                SectionHead(
                    heading: "Today",
                    count: todayList.length,
                ),
                todayList.length > 0
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: todayList.length,
                    itemBuilder: (c, i) {
                        return TaskTile(
                            task: todayList[i],
                            refreshList: refreshList,
                        );
                    },
                )
                : NothingPlanned(),
                SectionHead(
                    heading: "Tomorrow",
                    count: tomorrowList.length,
                ),
                tomorrowList.length > 0
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tomorrowList.length,
                    itemBuilder: (c, i) {
                        return TaskTile(
                            task: tomorrowList[i],
                            refreshList: refreshList,
                        );
                    },
                )
                : NothingPlanned(),
            ],
        );
    }
}

