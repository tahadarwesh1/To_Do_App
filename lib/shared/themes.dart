import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {
 static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      titleSpacing: 24,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      color: Colors.white,
      elevation: 0,
      
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelColor: Colors.grey,
    ),
    
    primarySwatch: Colors.blue,
  );
}
