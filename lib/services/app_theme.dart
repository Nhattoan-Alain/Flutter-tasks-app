import 'package:flutter/material.dart';

enum AppTheme {
  lightTheme,
  darkTheme,
}

class AppThemes {
  static final appThemeData = {
    AppTheme.darkTheme: ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      backgroundColor: const Color(0xFF212121),
      dividerColor: Colors.black54,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      textTheme: const TextTheme(
        bodyText2: TextStyle(color: Colors.white),
        subtitle1: TextStyle(color: Colors.white),
      ),
      drawerTheme: DrawerThemeData(
          scrimColor: Colors.black.withOpacity(0.5),
          backgroundColor: const Color(0xFF212121)),
      tabBarTheme: const TabBarTheme(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: Colors.deepPurple,
            width: 2.5,
          ),
        ),
      ),
      // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      //     backgroundColor: Colors.grey, unselectedItemColor: Colors.white),
    ),

    //
    //

    AppTheme.lightTheme: ThemeData(
      primarySwatch: Colors.deepPurple,
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      backgroundColor: const Color(0xFFE5E5E5),
      dividerColor: const Color(0xff757575),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.black),
        ),
      ),

      chipTheme: const ChipThemeData(backgroundColor: Colors.deepPurple),
      textTheme: const TextTheme(
          subtitle1: TextStyle(color: Colors.black),
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black)),
      scaffoldBackgroundColor: const Color(0xFFE5E5E5),
      drawerTheme: DrawerThemeData(
        scrimColor: Colors.deepPurple.withOpacity(0.5),
        backgroundColor: const Color(0xFFE5E5E5),
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: Color(0xFFE5E5E5),
      ),

      tabBarTheme: const TabBarTheme(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: Color(0xFFE5E5E5),
            width: 2.5,
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.deepPurple,
      ),

      // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      //     backgroundColor: Colors.grey,
      //     selectedItemColor: Colors.black,
      //     unselectedItemColor: Colors.white),
    ),
  };
}
