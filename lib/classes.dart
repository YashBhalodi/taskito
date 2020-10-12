import 'package:flutter/cupertino.dart';
import 'package:taskito/constant.dart';
import 'package:taskito/db.dart';

class Task {
    int id;
    String title;
    String note;
    int level;
    bool done;
    DateTime date;

    Task({this.done = false,@required this.title,@required this.date,@required this.note,@required this.level,this.id});

    Future<void> add() async {
        DBHelper db = new DBHelper();
        this.id = await db.addTask(this);
    }
    Future<void> update() async {
        DBHelper db = new DBHelper();
        await db.updateTask(this);
    }
    Future<void> delete() async {
        DBHelper db = new DBHelper();
        await db.deleteTask(this);
        if(!this.done)  Constant.updateGlobalScore(deletion: true);
    }
    Future<void> markDone() async {
        DBHelper db = new DBHelper();
        this.done = true;
        await db.updateTask(this);
        Constant.updateGlobalScore(level: this.level);
    }
    Task.fromMap(Map<String, dynamic>map) {
        this.id = map['id'] as int;
        this.date = DateTime.parse(map['date']);
        this.level = map['level'] as int;
        this.done = map['done'] as int == 1 ? true : false;
        this.title = map['title'] as String;
        this.note = map['note'] as String;
    }

    Map<String, dynamic> toMap() {
        var map = <String, dynamic>{
            'title': this.title,
            'done': this.done ? 1 : 0,
            'level': this.level,
            'date': Constant.dateFormatter.format(this.date),
            'note': this.note,
        };
        if (id != null) {
            map['id'] = id;
        }
        return map;
    }

    @override
    String toString() {
        return "{id:${this.id}\ttitle:${this.title}\tnote:${this.note}\tdone:${this.done}\tdate${this.date}";
    }

}