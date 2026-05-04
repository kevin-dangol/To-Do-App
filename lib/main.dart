// ignore_for_file: unused_local_variable, unused_import
import 'package:basic_todo_app/models/tasks.dart';
import 'package:basic_todo_app/screens/utils/create_task.dart';
import 'package:basic_todo_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  var db = await Hive.openBox('db');
  
  runApp(const MainApp());

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}
