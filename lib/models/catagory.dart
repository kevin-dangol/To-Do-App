// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'catagory.g.dart';

@HiveType(typeId: 0)
class Catagory extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  int colorValue;

  Catagory({
    required this.title,
    this.description,
    this.isCompleted = false,
    required Color color,
  }) : colorValue = color.value;

  Color get color => Color(colorValue);
}