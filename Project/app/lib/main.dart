//ignore_for_file: prefer_const_constructors
// import 'package:app/predictionscreen.dart';
import 'package:app/details_list.dart';
import 'package:flutter/material.dart';
import 'home.dart';
// import 'inputscreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/storage': (context) => DetailsList(),
      },
      // home: Home(),
      theme: ThemeData(
        textTheme:
            TextTheme(bodyMedium: TextStyle(fontWeight: FontWeight.w500)),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
