// ignore_for_file: unused_import

import 'package:basic_todo_app/models/tasks.dart';
import 'package:basic_todo_app/shared/colors.dart';
import 'package:basic_todo_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskTile extends StatelessWidget {

  final bool isDark;
  final Task tasks;
  final Function(Task) changeTask;
  final Function(Task) deleteTask;

  const TaskTile({super.key, required this.isDark, required this.tasks, required this.changeTask, required this.deleteTask});

  @override
  Widget build(BuildContext context) {

    final textColor = isDark ? const Color.fromARGB(255, 231, 231, 241) : mainTextColorDark;
    final ticksBorderColor = isDark ? tickBorderColorDark : tickBorderColor;
    final completedTaskBg = isDark ? completedTaskDark : completedTask;
    final completedTaskText = isDark ? completedTextDark : completedText;
    final completedTicks = isDark ? completedTickDark : completedTick;

    return Padding(

      padding: const EdgeInsets.all(10),

      child: GestureDetector(
        
          onTap: () {
              changeTask(tasks);
          },
        
          child: Container(
          
            decoration: BoxDecoration(
        
              color: tasks.isCompleted ? completedTaskBg : tasks.color,
        
              borderRadius: BorderRadius.circular(16),
        
              boxShadow: [
        
                BoxShadow(
                  color: const Color.fromARGB(45, 96, 96, 96),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
        
              ],
            ),
            
            child: Row(
          
              children: [
          
                Padding(
          
                  padding: const EdgeInsets.only(left: 10),
          
                  child: Checkbox(
          
                    activeColor: tasks.isCompleted? completedTicks: completedTicks,
          
                    side: BorderSide(
                      color: tasks.isCompleted? ticksBorderColor: ticksBorderColor,
                    ),
          
                    value: tasks.isCompleted,
          
                    onChanged: (_) {
                      changeTask(tasks);
                    }
                  ),
                ),
          
                Expanded(
                  child: Column(
                  
                    crossAxisAlignment: CrossAxisAlignment.start,
                  
                    children: [
                                  
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 8, left: 12, right: 12),
                        child: RichText(
                          text: TextSpan(
                            text: tasks.title,
                            style: TextStyle(
                              color: tasks.isCompleted? completedTaskText: textColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              decoration: tasks.isCompleted? TextDecoration.lineThrough: TextDecoration.none,
                              decorationThickness: 3,
                            ),
                          ),
                        ),
                      ),
                                  
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 20, right: 10),
                        child: RichText(
                          text: TextSpan(
                            text: tasks.description,
                            style: TextStyle(
                              color: tasks.isCompleted? completedTaskText: textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              decoration: tasks.isCompleted? TextDecoration.lineThrough: TextDecoration.none,
                              decorationThickness: 3,
                            ),
                          ),
                        ),
                      ),
                                  
                    ],
                  ),
                ),

                Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () => deleteTask(tasks),
                      icon: Icon(Icons.delete),
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      );
  }
}