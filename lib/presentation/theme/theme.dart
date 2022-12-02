import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo/presentation/utils/utils.dart';

enum AppTheme { lightTheme, darkTheme }

final appThemeData = {
  AppTheme.lightTheme: ThemeData(
      // brightness: Brightness.light,
      // textTheme: Theme.,
      // hintColor: Colors.grey,
      primaryColor: Utils.titleColor,
      unselectedWidgetColor: Colors.deepPurple,
      //odd color
      cardColor: Utils.todoOddColor,
      canvasColor: Utils.todoEvenColor,
      backgroundColor: Utils.bgColor),
  AppTheme.darkTheme: ThemeData(
      //  brightness: Brightness.dark,
      //  hintColor: Colors.grey,
      primaryColor: const Color(0xFFC5B2B8),
      unselectedWidgetColor: Colors.deepPurple,
      cardColor: const Color(0xFF0B525B),
      canvasColor: const Color(0xFF403F4C),
      backgroundColor: const Color(0xFF040506)),
};
