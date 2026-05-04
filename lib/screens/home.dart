import 'package:basic_todo_app/database/database.dart';
import 'package:basic_todo_app/models/tasks.dart';
import 'package:basic_todo_app/screens/utils/create_task.dart';
import 'package:basic_todo_app/screens/utils/task_tile.dart';
import 'package:basic_todo_app/shared/colors.dart';
import 'package:basic_todo_app/shared/functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage
({super.key});

  @override
  State<HomePage
> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final db = Hive.box('db');
  DatabaseServices dbs = DatabaseServices();
  bool isDark = false;

  @override
  void initState() {

    if(db.get('UNFINISHEDTASKS') == null && db.get('FINISHEDTASKS') == null) {

      dbs.createInitialData();

    }else{

      dbs.loadData();
      isDark = dbs.isDark;

    }

    super.initState();
    
  }

  void changeTheme(){
    setState(() {
      dbs.updateData();
      isDark = !isDark;
    });
  }

  void changeTask(Task task) {
    setState(() {

      task.isCompleted = !task.isCompleted;

      if (task.isCompleted) {

        dbs.unfinishedTasks.remove(task); // remove by object
        dbs.finishedTasks.add(task);
        dbs.updateData();

      } else {

        dbs.finishedTasks.remove(task);
        dbs.unfinishedTasks.add(task);
        dbs.updateData();

      }

    });
  }
  
  void deleteTask(Task task) {
    setState(() {

      if (task.isCompleted) {

        dbs.finishedTasks.remove(task);
        dbs.updateData();

      } else {

        dbs.unfinishedTasks.remove(task);
        dbs.updateData();

      }
      
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        backgroundColor: isDark? appbarColor: appbarDark,

        foregroundColor: isDark? iconColorDark:iconColor,

        leading: GestureDetector(

          child: Icon(Icons.menu),

        ),

        actions: [

          GestureDetector(
            onTap: () {
              changeTheme();
            },
            child: isDark ? Icon(Icons.light_mode,) : Icon(Icons.dark_mode,),
          ),
          
        ],

        actionsPadding: EdgeInsets.only(right: 10),

        title: Text('TodoApp'),

        centerTitle: true,

      ),

      floatingActionButton: FloatingActionButton(

        onPressed: () async {

          final newTask = await showModalBottomSheet<Task>(

            context: context,
            isScrollControlled: true,

            backgroundColor: isDark ? bodyColor : bodyColorDark,

            shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              side: BorderSide(color: const Color.fromARGB(255, 40, 60, 121)),

            ),

            builder: (context) {

              return SizedBox(

                height: MediaQuery.of(context).size.height * 0.8,
                child: CreateTask(isDark: isDark),

              );

            },
          );

          if (newTask != null) {

            setState(() {
              dbs.unfinishedTasks.add(newTask);
              dbs.updateData();
            });

          }
        },

        foregroundColor: Colors.white,
        backgroundColor: isDark ? addColorDark : addColorDark,

        shape: CircleBorder(),

        child: Icon(Icons.add),

      ),

      body: SafeArea(

        child: Container(
          width: double.infinity,
          color: isDark ? bodyColor : bodyColorDark,

          child: ListView(
            padding: EdgeInsets.all(20),

            children: [

              dbs.finishedTasks.isNotEmpty? Container(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(25, 0, 0, 0),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),

                child: Column(
                  children: [

                    title('Completed Tasks', isDark),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: dbs.finishedTasks.length,
                      itemBuilder: (context, index) {
                        final task = dbs.finishedTasks[index];
                        return TaskTile(
                          isDark: isDark,
                          tasks: task,
                          changeTask: changeTask,
                          deleteTask: deleteTask,
                        );
                      },
                      separatorBuilder: (_, _) => SizedBox(height: 1),
                    ),
                    
                    if (dbs.unfinishedTasks.isNotEmpty && dbs.finishedTasks.isEmpty)
                      emptyMessage("No Task Completed!", isDark),
                  ],
                ),
              ): SizedBox(),

              SizedBox(height: 20,),

              Container(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(25, 0, 0, 0),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),

                child: Column(
                  children: [

                    title('Tasks', isDark),

                    if (dbs.unfinishedTasks.isNotEmpty)
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: dbs.unfinishedTasks.length,
                        itemBuilder: (context, index) {
                          final task = dbs.unfinishedTasks[index];
                          return TaskTile(
                            isDark: isDark,
                            tasks: task,
                            changeTask: changeTask,
                            deleteTask: deleteTask,
                          );
                        },
                        separatorBuilder: (_, _) => SizedBox(height: 1),
                      ),

                    if (dbs.unfinishedTasks.isEmpty && dbs.finishedTasks.isNotEmpty)
                      emptyMessage("All Task Completed!", isDark),

                    if (dbs.unfinishedTasks.isEmpty && dbs.finishedTasks.isEmpty)
                      emptyMessage("No tasks added yet.", isDark),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}