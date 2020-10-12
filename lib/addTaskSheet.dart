import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskito/classes.dart';
import 'package:taskito/constant.dart';
import 'package:taskito/themeData.dart';

class AddTaskSheet extends StatefulWidget {
  final Function refreshList;

  const AddTaskSheet({Key key, this.refreshList}) : super(key: key);

  @override
  _AddTaskSheetState createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  String title;
  String note;
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  PickedDate _pickedDate = PickedDate.today;
  Level _level = Level.three;

  Future<void> _saveTask() async {
    int level;
    DateTime date;
    switch (_level) {
      case Level.one:
        level = 1;
        break;
      case Level.two:
        level = 2;
        break;
      case Level.three:
        level = 3;
        break;
      case Level.four:
        level = 4;
        break;
      case Level.five:
        level = 5;
        break;
    }
    switch (_pickedDate) {
      case PickedDate.today:
        date = DateTime.now();
        break;
      case PickedDate.tomorrow:
        date = DateTime.now().add(Duration(days: 1));
        break;
    }
    Task t = Task(
        level: level,
        note: noteController.text,
        title: titleController.text,
        date: date,
        done: false);
    await t.add();
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: 16.0,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(0.0),
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Add Task",
                          style: LightTheme.headingTextStyle,
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        TextField(
                          maxLines: 1,
                          maxLength: 75,
                          controller: titleController,
                          style: LightTheme.inputTitleTextStyle,
                          decoration: InputDecoration(
                            labelStyle: LightTheme.sectionHeadingStyle,
                            hintText: 'Grade Maths Assignment',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: LightTheme.formFieldFillColor,
                            hasFloatingPlaceholder: true,
                            alignLabelWithHint: true,
                            labelText: "Title",
                            contentPadding: Constant.textFieldPadding,
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        TextField(
                          maxLines: 6,
                          minLines: 4,
                          maxLength: 500,
                          controller: noteController,
                          style: LightTheme.inputNoteTextStyle,
                          decoration: InputDecoration(
                            labelStyle: LightTheme.sectionHeadingStyle,
                            hintText: 'Assignment number 5 to 7...',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: LightTheme.formFieldFillColor,
                            hasFloatingPlaceholder: true,
                            alignLabelWithHint: true,
                            labelText: "Note",
                            contentPadding: Constant.textFieldPadding,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: RadioListTile<PickedDate>(
                          onChanged: (v) {
                            setState(() {
                              _pickedDate = v;
                            });
                          },
                          value: PickedDate.today,
                          title: Text("Today"),
                          groupValue: _pickedDate,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<PickedDate>(
                          onChanged: (v) {
                            setState(() {
                              _pickedDate = v;
                            });
                          },
                          value: PickedDate.tomorrow,
                          title: Text("Tomorrow"),
                          groupValue: _pickedDate,
                        ),
                      ),
                    ],
                  ),
                  /*Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    RadioListTile<Level>(
                      onChanged: (v) {
                        setState(() {
                          _level = v;
                        });
                      },
                      value: Level.one,
                      title: Text("1"),
                      groupValue: _level,
                    ),
                    RadioListTile<Level>(
                      onChanged: (v) {
                        setState(() {
                          _level = v;
                        });
                      },
                      value: Level.two,
                      title: Text("2"),
                      groupValue: _level,
                    ),
                    RadioListTile<Level>(
                      onChanged: (v) {
                        setState(() {
                          _level = v;
                        });
                      },
                      value: Level.three,
                      title: Text("3"),
                      groupValue: _level,
                    ),
                    RadioListTile<Level>(
                      onChanged: (v) {
                        setState(() {
                          _level = v;
                        });
                      },
                      value: Level.four,
                      title: Text("4"),
                      groupValue: _level,
                    ),
                    RadioListTile<Level>(
                      onChanged: (v) {
                        setState(() {
                          _level = v;
                        });
                      },
                      value: Level.five,
                      title: Text("5"),
                      groupValue: _level,
                    ),
                  ],
                ),*/
                ],
              ),
            ),
            SizedBox(
              height: 52.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Pallet.isabelline,
                      child: Text(
                        "Cancle",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Pallet.midnightGreenEagleGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        _saveTask();
                        widget.refreshList();
                        Navigator.of(context).pop();
                      },
                      color: Pallet.midnightGreenEagleGreen,
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Pallet.isabelline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

enum PickedDate { today, tomorrow }
enum Level { one, two, three, four, five }
