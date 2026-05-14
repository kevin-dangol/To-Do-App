// ignore_for_file: unused_import, unnecessary_import

import 'dart:ui';
import 'package:basic_todo_app/database/database.dart';
import 'package:basic_todo_app/models/catagory.dart';
import 'package:basic_todo_app/models/tasks.dart';
import 'package:basic_todo_app/screens/home.dart';
import 'package:basic_todo_app/shared/colors.dart';
import 'package:basic_todo_app/shared/functions.dart';
import 'package:flutter/material.dart';

class CreateCatagory extends StatefulWidget {

  final bool isDark;
  
  const CreateCatagory({super.key, required this.isDark});

  @override
  State<CreateCatagory> createState() => _CreateCatagoryState();
}

class _CreateCatagoryState extends State<CreateCatagory> {

  DatabaseServices dbs = DatabaseServices();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  Color selectedColor = Colors.red;

  final List<Color> colors = [
    const Color.fromARGB(105, 230, 129, 122),
    const Color.fromARGB(115, 33, 149, 243),
    const Color.fromARGB(115, 76, 175, 79),
    const Color.fromARGB(115, 255, 153, 0),
    const Color.fromARGB(115, 155, 39, 176),
    const Color.fromARGB(115, 96, 125, 139),
  ];

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: Padding(
      
        padding: const EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 20),
      
        child: Column(
      
          crossAxisAlignment: CrossAxisAlignment.start,
      
          children: [
      
            Center(

              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

            ),
      
            Padding(
              padding: const EdgeInsets.all(14),
              child: RichText(
                text: TextSpan(
                  text: 'Create Catagory',
                  style: TextStyle(
                    color: widget.isDark ? textColorDark: textColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
      
            Form(
      
              key: formKey,
      
              child: Column(

                children: [
      
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Name',
                      style: TextStyle(
                        color: widget.isDark ? textColorDark: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
      
                  SizedBox(height: 10),
      
                  TextFormField(

                    controller: titleController,

                    decoration: inputDecoration(hintText: 'Name of the Catagory', isDark: widget.isDark),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a title';
                      }
                      return null;
                    },

                  ),
      
                  SizedBox(height: 20),
      
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Description',
                      style: TextStyle(
                        
                        color: widget.isDark ? textColorDark: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold

                      ),
                    ),
                  ),
      
                  SizedBox(height: 10),
      
                  TextFormField(

                    minLines: 5,
                    maxLines: null,

                    textAlignVertical: TextAlignVertical.top,

                    controller: descController,

                    decoration: inputDecoration(hintText: 'Description of the Catagory', isDark: widget.isDark),

                  ),
      
                  SizedBox(height: 20),
      
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select Color',
                      style: TextStyle(
                        
                        color: widget.isDark ? textColorDark: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold

                      ),
                    ),
                  ),
      
                  SizedBox(height: 10),
      
                  Row(

                    children: colors.map((color) {

                      final isSelected = selectedColor == color;

                      return GestureDetector(

                        onTap: () {
                          setState(() {
                            selectedColor = color;
                          });
                        },

                        child: Container(

                          margin: EdgeInsets.only(right: 10),

                          width: 35,
                          height: 35,

                          decoration: BoxDecoration(

                            color: color,
                            shape: BoxShape.circle,
                            border: isSelected ? Border.all(color: Colors.black, width: 3) : null,

                          ),
                        ),

                      );
                    }).toList(),
                  ),
      
                  SizedBox(height: 30),
      
                  ElevatedButton(

                    onPressed: () {

                      if (formKey.currentState!.validate()) {
                        final newCatagory = Catagory(
                          title: titleController.text,
                          description: descController.text,
                          color: selectedColor,
                        );

                        Navigator.of(context).pop(newCatagory);

                      }
                      
                    },
                    style: ElevatedButton.styleFrom(

                      minimumSize: Size(double.infinity, 50),

                      backgroundColor: widget.isDark ? addColorDark : addColorDark,
                      foregroundColor: Colors.white,

                    ),
                    child: Text('Create Catagory'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}