import 'package:flutter/material.dart';
import 'package:flutter_sqflite_study_sample/repository/sql_database.dart';
import 'package:flutter_sqflite_study_sample/src/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SqlDataBase.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
