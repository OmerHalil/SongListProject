import 'package:flutter/material.dart';
import 'package:song/services/Locator.dart';
import 'package:song/services/SharedPreDB.dart';
import 'Pages/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  //Dependency injection
  setUpLocator();



  runApp(
    MaterialApp(
      home: HomePage(),
    )
  );
}