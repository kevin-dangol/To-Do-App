// ignore_for_file: unused_import, deprecated_member_use

import 'dart:ui';
import 'package:basic_todo_app/database/database.dart';
import 'package:basic_todo_app/screens/category.dart';
import 'package:basic_todo_app/screens/home.dart';
import 'package:basic_todo_app/screens/settings.dart';
import 'package:basic_todo_app/screens/utils/drawer.dart';
import 'package:basic_todo_app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

enum ScreenType {
  home,
  categories,
  settings,
}

class _WrapperState extends State<Wrapper> {

  final db = Hive.box('db');
  DatabaseServices dbs = DatabaseServices();
  ScreenType currentScreen = ScreenType.home;
  String firstName  = 'Kevin';
  String lastName  = 'Dangol';
  
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  double rotation = 0;
  bool isDrawerOpen = false;

  void openDrawer() {
    final height = MediaQuery.of(context).size.height;

    setState(() {
      xOffset = 240;
      yOffset = height * 0.08;
      scaleFactor = 0.88;
      // rotation = -0.03;
      isDrawerOpen = true;
    });
  }

  void closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      rotation = 0;
      isDrawerOpen = false;
    });
  }

  void toggleDrawer() {
    setState(() {
      isDrawerOpen ? closeDrawer() : openDrawer();
    });
  }

  void changeScreen(ScreenType screen) {
    setState(() {
      currentScreen = screen;
      closeDrawer();
    });
  }

  Widget getScreen() {
    switch (currentScreen) {
      case ScreenType.home:
        return HomePage(toggleDrawer: toggleDrawer);
      case ScreenType.categories:
        return CategoryPage(toggleDrawer: toggleDrawer);
      case ScreenType.settings:
        return SettingsPage(toggleDrawer: toggleDrawer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D1B4C),
      body: Stack(
        children: [

          MyDrawer(
            closeDrawer: closeDrawer,
            changeScreen: changeScreen,
            firstName: firstName,
            lastName: lastName,

          ),
      
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOutCubic,
            clipBehavior: Clip.antiAlias,

            transform: Matrix4.identity()
              ..translate(xOffset, yOffset)
              ..scale(scaleFactor),

            decoration: BoxDecoration(
              color: dbs.isDark ? bodyColor : bodyColorDark,
              borderRadius: BorderRadius.circular(isDrawerOpen ? 60 : 0),
              boxShadow: isDrawerOpen
                  ? [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 20,
                        offset: Offset(-5, 10),
                      ),
                    ]
                  : [],
            ),

            child: Stack(
              children: [
                RepaintBoundary(child: getScreen()),
                if (isDrawerOpen)
                  GestureDetector(
                    onTap: closeDrawer,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}