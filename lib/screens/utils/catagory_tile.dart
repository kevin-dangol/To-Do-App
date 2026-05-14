// ignore_for_file: unused_import

import 'package:basic_todo_app/models/catagory.dart';
import 'package:basic_todo_app/shared/colors.dart';
import 'package:basic_todo_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CatagoryTile extends StatelessWidget {

  final bool isDark;
  final Catagory catagory;
  final Function(Catagory) changeTask;
  final Function(Catagory) deleteTask;

  const CatagoryTile({super.key, required this.isDark, required this.catagory, required this.changeTask, required this.deleteTask});

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
              changeTask(catagory);
          },
        
          child: Container(
          
            decoration: BoxDecoration(
        
              color: catagory.isCompleted ? completedTaskBg : catagory.color,
        
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
          
                    activeColor: catagory.isCompleted? completedTicks: completedTicks,
          
                    side: BorderSide(
                      color: catagory.isCompleted? ticksBorderColor: ticksBorderColor,
                    ),
          
                    value: catagory.isCompleted,
          
                    onChanged: (_) {
                      changeTask(catagory);
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
                            text: catagory.title,
                            style: TextStyle(
                              color: catagory.isCompleted? completedTaskText: textColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              decoration: catagory.isCompleted? TextDecoration.lineThrough: TextDecoration.none,
                              decorationThickness: 3,
                            ),
                          ),
                        ),
                      ),
                                  
                      Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 20, right: 10),
                        child: RichText(
                          text: TextSpan(
                            text: catagory.description,
                            style: TextStyle(
                              color: catagory.isCompleted? completedTaskText: textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              decoration: catagory.isCompleted? TextDecoration.lineThrough: TextDecoration.none,
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
                      onPressed: () => deleteTask(catagory),
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