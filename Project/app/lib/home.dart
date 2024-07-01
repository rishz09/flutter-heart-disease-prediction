//ignore_for_file: prefer_const_constructors
import 'package:app/data_analysis.dart';
import 'package:app/detail.dart';
import 'package:app/details_list.dart';
import 'package:app/health_recommendations.dart';
import 'package:app/inputscreen.dart';
import 'package:flutter/material.dart';
// import 'loading.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Home',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 25),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 226, 89, 135),
        elevation: 3.0,
        shadowColor: Colors.black,
      ),
      backgroundColor: const Color.fromARGB(255, 255, 218, 231),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      'assets/logo.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'HeartMate',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 18, 105, 176),
                  ),
                ),
                SizedBox(height: 0),
                Center(
                  child: Text(
                    'Bridging Science and Wellness',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1.5),
                  ),
                ),
                SizedBox(height: 40),
                BigBox(
                  text: 'Input Data',
                  // color: Color.fromARGB(255, 247, 116, 159),
                  color: Color.fromARGB(255, 254, 177, 203),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InputScreen(
                                edit: false,
                                detail: Detail(-1, -1, -1, -1, -1, -1, -1, -1,
                                    -1, -1, -1, -1000, -1, '', ''),
                              )),
                    );
                  },
                ),
                SizedBox(height: 20),
                BigBox(
                  text: 'Saved Profiles',
                  color: Color.fromARGB(255, 254, 177, 203),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DetailsList()));
                  },
                ),
                SizedBox(height: 20),
                BigBox(
                  text: 'Data Visualisation',
                  color: Color.fromARGB(255, 254, 177, 203),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DataAnalysisScreen()));
                  },
                ),
                SizedBox(height: 20),
                BigBox(
                  text: '\t\t\t\t\t\t\t\t\t\tHealth\nRecommendations',
                  color: Color.fromARGB(255, 254, 177, 203),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HealthPage()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BigBox extends StatelessWidget {
  final Color color;
  final dynamic onTap;
  final String text;

  const BigBox({required this.color, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        height: 70,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color.fromARGB(255, 77, 77, 77), // Set border color
            width: 2.0, // Set border width
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
