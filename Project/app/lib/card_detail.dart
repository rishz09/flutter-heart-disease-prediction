//ignore_for_file: prefer_const_constructors
// import 'package:app/database_helper.dart';
import 'package:app/data_analysis.dart';
import 'package:app/details_list.dart';
import 'package:app/health_recommendations.dart';
import 'package:app/inputscreen.dart';
import 'package:flutter/material.dart';
import 'detail.dart';
// import 'details_list.dart';
import 'mapping.dart' as mapfile;

class CardDetail extends StatefulWidget {
  final Detail detail;
  const CardDetail(this.detail) : super();

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  int flag = 0;

  @override
  Widget build(BuildContext context) {
    Detail detail = widget.detail;
    if (flag == 0) {}
    // TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          detail.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.popUntil(context, ModalRoute.withName('/'));
            Navigator.pop(context);
            // Push a new instance of the FirstScreen
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => DetailsList()));
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            icon: Icon(Icons.home_sharp),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 226, 89, 135),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 218, 231),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 450,
              width: 350,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  // color: Color.fromARGB(255, 77, 77, 77), // Set border color
                  width: 2.0, // Set border width
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Age: ${detail.age} years'),
                  SizedBox(height: 20),
                  Text('Sex: ${mapfile.sexVals[detail.sex.toInt()]}'),
                  SizedBox(height: 20),
                  Text(
                      'Chest Pain Type: ${mapfile.chestPainTypeVals[detail.chestPainType.toInt()]}'),
                  SizedBox(height: 20),
                  Text('Fasting Blood Sugar: ${detail.fastingBSTemp}'),
                  SizedBox(height: 20),
                  Text(
                      'Resting ECG: ${mapfile.restingECGVals[detail.restingECG.toInt()]}'),
                  SizedBox(height: 20),
                  Text(
                      'Exercise-induced Angina: ${mapfile.exerciseAnginaVals[detail.exerciseAngina.toInt()]}'),
                  SizedBox(height: 20),
                  Text(
                      'ST Slope: ${mapfile.stSlopeVals[detail.stSlope.toInt()]}'),
                  SizedBox(height: 20),
                  Text('Resting Blood Pressure: ${detail.restingBP} mm Hg'),
                  SizedBox(height: 20),
                  Text('Cholesterol: ${detail.cholesterol} mm/dl'),
                  SizedBox(height: 20),
                  Text('Max Heart Rate: ${detail.maxHR} bpm'),
                  SizedBox(height: 20),
                  Text('Oldpeak: ${detail.oldpeak}'),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                'Probability of Having Cardiovascular Disease: \n${detail.pred.toStringAsFixed(2)}%',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    // Set border radius and color
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                        color: Color.fromARGB(255, 21, 107, 176), width: 1),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InputScreen(
                                edit: true,
                                detail: detail,
                              )));
                },
                child: Text('Edit Profile'),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(175, 40),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      // Set border radius and color
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                          color: Color.fromARGB(255, 21, 107, 176), width: 1),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DataAnalysisScreen()));
                  },
                  child: Text('Data Visualisation'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    maximumSize: Size(175, 40),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      // Set border radius and color
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                          color: Color.fromARGB(255, 21, 107, 176), width: 1),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HealthPage()));
                  },
                  child: Text(
                    'Health Recommendations',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
