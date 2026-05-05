// ignore_for_file: unused_import, must_be_immutable

import 'package:basic_todo_app/screens/home.dart';
import 'package:basic_todo_app/wapper.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {

  final VoidCallback closeDrawer;
  final Function(ScreenType) changeScreen;
  final String firstName;
  final String lastName;

  const MyDrawer({
    super.key,
    required this.closeDrawer, 
    required this.changeScreen,
    required this.firstName,
    required this.lastName,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF0D1B4C),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Stack(
        
        children: [

          Padding(

            padding: const EdgeInsets.only(top: 50, right: 50),

            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                GestureDetector(

                  onTap: widget.closeDrawer,

                  child: Container(

                    padding: EdgeInsets.all(10),

                    decoration: BoxDecoration(

                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white24),

                    ),

                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
          
              SizedBox(height: 100),
          
              CircleAvatar(

                radius: 60,

              ),
          
              SizedBox(height: 20),
          
              Text(
                widget.firstName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                widget.lastName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
          
              SizedBox(height: 30),

              drawerItem(Icons.home_rounded, "Home", ScreenType.home),
              drawerItem(Icons.grid_view_rounded, "Categories", ScreenType.categories),
              drawerItem(Icons.settings_rounded, "Settings", ScreenType.settings),
          
              Spacer(),
          
              Text(
                "Haha\nNoob",
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget drawerItem(IconData icon, String title,  ScreenType screen) {

    return Padding(

      padding: const EdgeInsets.symmetric(vertical: 12),

      child: GestureDetector(

        onTap: () {

          widget.changeScreen(screen);

        },

        child: Row(

          children: [
        
            Icon(
              icon,
              color: Colors.white70,
              size: 28,
            ),
        
            SizedBox(width: 16),
            
            Text(
              title,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18
              ),
            ),
          ],
        ),
      ),
    );
  }
}