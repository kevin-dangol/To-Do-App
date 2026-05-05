// ignore_for_file: unused_import

import 'package:basic_todo_app/models/tasks.dart';
import 'package:basic_todo_app/shared/functions.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseServices{

  List<Task> unfinishedTasks = [];
  List<Task> finishedTasks = [];
  bool isDark = false;

  final db = Hive.box('db');

  void createInitialData() {

    unfinishedTasks = [

      Task(title: 'Exercise', color: Colors.red, description: 'Exercise for at least 20 mins.'),
      Task(title: 'Study', color: Colors.red, description: 'Study for at least 1 hr.'),

    ];

  }

  void loadData() {

    unfinishedTasks = (db.get('UNFINISHEDTASKS') ?? []).cast<Task>();
    finishedTasks = (db.get('FINISHEDTASKS') ?? []).cast<Task>();
    isDark = db.get('ISDARK') ?? false;

  }

  void updateData() {

    db.put('UNFINISHEDTASKS', unfinishedTasks);
    db.put('FINISHEDTASKS', finishedTasks);
    db.put('ISDARK', isDark);

  }

}