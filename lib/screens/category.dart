// ignore_for_file: unused_import

import 'package:basic_todo_app/database/database.dart';
import 'package:basic_todo_app/models/tasks.dart';
import 'package:basic_todo_app/screens/utils/create_task.dart';
import 'package:basic_todo_app/screens/utils/funcation.dart';
import 'package:basic_todo_app/screens/utils/task_tile.dart';
import 'package:basic_todo_app/shared/colors.dart';
import 'package:basic_todo_app/shared/functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategoryPage extends StatefulWidget {

  final VoidCallback toggleDrawer;

  const CategoryPage ({super.key, required this.toggleDrawer});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  final db = Hive.box('db');
  DatabaseServices dbs = DatabaseServices();

  @override
  void initState() {
    super.initState();
    dbs.loadData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        backgroundColor: dbs.isDark? appbarColor: appbarDark,

        foregroundColor: dbs.isDark? iconColorDark:iconColor,

        leading: GestureDetector(

          onTap: widget.toggleDrawer,

          child: Icon(Icons.menu),

        ),

        actions: [

          GestureDetector(
            onTap: () {
              setState(() {
                dbs.isDark = !dbs.isDark;
                dbs.updateData();
              });
            },
            child: dbs.isDark ? Icon(Icons.light_mode,) : Icon(Icons.dark_mode,),
          ),
          
        ],

        actionsPadding: EdgeInsets.only(right: 10),

        title: Text('TodoApp'),

        centerTitle: true,

      ),

      body: SafeArea(

        child: Container(
        
          width: double.infinity,
          color: dbs.isDark ? bodyColor : bodyColorDark,
        
          child: title('Categorys', dbs.isDark)
        
        ),
      ),
    );
  }
}