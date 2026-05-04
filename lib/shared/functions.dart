// ignore_for_file: unused_import

import 'package:basic_todo_app/screens/home.dart';
import 'package:basic_todo_app/shared/colors.dart';
import 'package:flutter/material.dart';

InputDecoration inputDecoration({required String hintText, required bool isDark}){

  return InputDecoration(
                
    hintText: hintText,
    hintStyle: TextStyle(

      color: isDark ? textColorDark: textColor,
      
    ),

    enabledBorder: OutlineInputBorder(

      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(

        color: isDark ? textColorDark: textColor,

      ),

    ),

    focusedBorder: OutlineInputBorder(

      borderSide: BorderSide(

        strokeAlign: BorderSide.strokeAlignCenter,
        width: 3,
        color: isDark ? textColorDark: textColor,
        
      ),

      borderRadius: BorderRadius.circular(15),

    ),

    errorBorder: OutlineInputBorder(

      borderSide: BorderSide(

        color: Colors.red,

      ),

      borderRadius: BorderRadius.circular(15),

    ),

    focusedErrorBorder: OutlineInputBorder(

      borderSide: BorderSide(

        color: Colors.red,
        
      ),

      borderRadius: BorderRadius.circular(15),

    ),

  );

}

Widget emptyMessage(String message, bool isDark) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 40),
    child: Center(
      child: Text(
        message,
        style: TextStyle(
          color: isDark ? textColorDark : textColor,
          fontSize: 18,
        ),
      ),
    ),
  );
}

Widget title(String title, bool isDark){

  return Align(
    alignment: AlignmentGeometry.topStart,
    child: Padding(
      padding: const EdgeInsets.only(top: 15, right: 20, left: 15),
      child: Text(
        title,
        style: TextStyle(
          color: isDark ? textColorDark : textColor,
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

}