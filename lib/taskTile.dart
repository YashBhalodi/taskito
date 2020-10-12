import 'package:flutter/material.dart';
import 'package:taskito/classes.dart';
import 'package:taskito/constant.dart';
import 'package:taskito/themeData.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final Function refreshList;

  const TaskTile({Key key, @required this.task, @required this.refreshList}) : super(key: key);

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool done;
  bool editMode = false;
  TextEditingController titleController;
  TextEditingController noteController;

  @override
  void initState() {
    done = widget.task.done;
    titleController = TextEditingController(text: widget.task.title);
    noteController = TextEditingController(text: widget.task.note);
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: done ? 0.5 : 1.0,
      child: ExpansionTile(
        backgroundColor: LightTheme.taskTileBackgroundColor,
        trailing: Container(
          height: 0.0,
          width: 0.0,
        ),
        title: TextField(
          enabled: editMode,
          controller: titleController,
          style: editMode ? LightTheme.inputTitleTextStyle : LightTheme.titleTextStyle,
          maxLength: 75,
          maxLines: 1,
          onChanged: (s) {
            setState(() {
              widget.task.title = titleController.text;
            });
          },
          decoration: InputDecoration(
            filled: editMode,
            fillColor: LightTheme.formFieldFillColor,
            contentPadding: EdgeInsets.all(0.0),
            border: InputBorder.none,
            counter: Container(),
          ),
        ),
        initiallyExpanded: false,
        onExpansionChanged: (a) {
          if (a == false && editMode) {
            widget.task.title = titleController.text;
            widget.task.note = noteController.text;
          }
        },
        leading: Checkbox(
          activeColor: LightTheme.checkBoxActiveColor,
          checkColor: LightTheme.checkBoxCheckColor,
          onChanged: (v) async {
            if (v) {
              setState(() {
                done = v;
                widget.task.done = done;
              });
              await widget.task.markDone();
              widget.refreshList;
            }
          },
          value: done,
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 32.0, top: 0.0, bottom: 8.0),
            child: TextField(
              autofocus: true,
              controller: noteController,
              onChanged: (s) {
                setState(() {
                  widget.task.note = noteController.text;
                });
              },
              enabled: editMode,
              minLines: 4,
              maxLines: 6,
              maxLength: 500,
              scrollPhysics: AlwaysScrollableScrollPhysics(),
              style: editMode ? LightTheme.inputNoteTextStyle : LightTheme.noteTextStyle,
              decoration: InputDecoration(
                filled: editMode,
                fillColor: LightTheme.formFieldFillColor,
                hintText: "Edit to add note...",
                border: InputBorder.none,
                counter: Container(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                width: 24.0,
              ),
              Chip(
                backgroundColor: Pallet.cultured,
                label: Text(widget.task.level.toString()),
                avatar: Icon(
                  Icons.star,
                  color: Pallet.satinSheenGold,
                ),
              ),
              Spacer(),
              editMode
                  ? IconButton(
                      onPressed: () async {
                        setState(() {
                          widget.task.title = titleController.text;
                          widget.task.note = noteController.text;
                          editMode = !editMode;
                        });
                        FocusScope.of(context).unfocus();
                        await widget.task.update();
                      },
                      icon: Icon(
                        Icons.save,
                        color: Pallet.pacificBlue,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          editMode = !editMode;
                        });
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Pallet.maximumBlueGreen,
                      ),
                    ),
              SizedBox(
                width: 8.0,
              ),
              IconButton(
                onPressed: () async {
                  await widget.task.delete();
                  Constant.showDummyAds(context);
                  widget.refreshList();
                },
                icon: Icon(
                  Icons.delete,
                  color: Pallet.indianRed,
                ),
              ),
              SizedBox(
                width: 8.0,
              )
            ],
          )
        ],
      ),
    );
  }
}
