//ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:app/constants.dart';
import 'package:app/data_analysis.dart';
import 'package:app/database_helper.dart';
import 'package:app/detail.dart';
import 'package:app/health_recommendations.dart';
// import 'package:app/home.dart';
import 'package:app/response.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PredictionScreen extends StatefulWidget {
  final int? age,
      sex,
      chestPainType,
      fastingBS,
      restingECG,
      exerciseAngina,
      stSlope;
  final double? restingBP, fastingBSTemp, cholesterol, maxHR, oldpeak;
  final bool? edit;
  final Detail? detail;

  const PredictionScreen(
      {this.age,
      this.sex,
      this.chestPainType,
      this.fastingBS,
      this.fastingBSTemp,
      this.restingECG,
      this.exerciseAngina,
      this.stSlope,
      this.restingBP,
      this.cholesterol,
      this.maxHR,
      this.oldpeak,
      this.edit,
      this.detail})
      : super();

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  int? age, sex, chestPainType, fastingBS, restingECG, exerciseAngina, stSlope;
  double? restingBP, cholesterol, fastingBSTemp, maxHR, oldpeak;
  String url = '', predRounded = '', title = '';
  late double output;
  late bool edit;
  var data;
  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<void> getPrediction() async {
    data = await fetchdata(url);
    var decoded = jsonDecode(data);
    setState(() {
      output = decoded['output'];
      predRounded = output.toStringAsFixed(4);
      predRounded = (double.parse(predRounded) * 100).toString();
    });
  }

  @override
  void initState() {
    age = widget.age;
    sex = widget.sex;
    chestPainType = widget.chestPainType;
    fastingBS = widget.fastingBS;
    fastingBSTemp = widget.fastingBSTemp;
    restingECG = widget.restingECG;
    exerciseAngina = widget.exerciseAngina;
    stSlope = widget.stSlope;
    restingBP = widget.restingBP;
    cholesterol = widget.cholesterol;
    maxHR = widget.maxHR;
    oldpeak = widget.oldpeak;
    edit = widget.edit!;

    url = 'http://10.0.2.2:5000/api?Age=${age.toString()}'
        '&RestingBP=${restingBP.toString()}'
        '&Cholesterol=${cholesterol.toString()}'
        '&MaxHR=${maxHR.toString()}'
        '&FastingBS=${fastingBS.toString()}'
        '&Oldpeak=${oldpeak.toString()}'
        '&Sex=${sex.toString()}'
        '&ChestPainType=${chestPainType.toString()}'
        '&RestingECG=${restingECG.toString()}'
        '&ExerciseAngina=${exerciseAngina.toString()}'
        '&ST_Slope=${stSlope.toString()}';

    super.initState();

    getPrediction();
  }

  @override
  Widget build(BuildContext context) {
    Detail detail = widget.detail!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Prediction',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: paramDecoration(),
                  child: Text(
                    'Chances of developing cardiovascular disease:\n$predRounded%',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 45),
                ElevatedButton(
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
                    if (edit == false) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Profile Name'),
                            content: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter profile name',
                              ),
                              onChanged: (value) {
                                title = value;
                              },
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  print(fastingBSTemp);
                                  Navigator.of(context).pop();
                                  _save(Detail(
                                      age!,
                                      sex!,
                                      chestPainType!,
                                      fastingBS!,
                                      fastingBSTemp!,
                                      restingECG!,
                                      exerciseAngina!,
                                      stSlope!,
                                      restingBP!,
                                      cholesterol!,
                                      maxHR!,
                                      oldpeak!,
                                      double.parse(predRounded),
                                      '',
                                      title));
                                },
                                child: Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Choose One'),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    detail.age = age!;
                                    detail.chestPainType = chestPainType!;
                                    detail.cholesterol = cholesterol!;
                                    detail.exerciseAngina = exerciseAngina!;
                                    detail.fastingBS = fastingBS!;
                                    detail.fastingBSTemp = fastingBSTemp!;
                                    detail.maxHR = maxHR!;
                                    detail.oldpeak = oldpeak!;
                                    detail.pred = double.parse(predRounded);
                                    detail.restingBP = restingBP!;
                                    detail.restingECG = restingECG!;
                                    detail.sex = sex!;
                                    detail.stSlope = stSlope!;

                                    Navigator.of(context).pop();
                                    _update(detail);
                                  },
                                  child: Text('Update'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Profile Name'),
                                          content: TextField(
                                            decoration: InputDecoration(
                                              hintText: 'Enter profile name',
                                            ),
                                            onChanged: (value) {
                                              title = value;
                                            },
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                _save(Detail(
                                                    age!,
                                                    sex!,
                                                    chestPainType!,
                                                    fastingBS!,
                                                    fastingBSTemp!,
                                                    restingECG!,
                                                    exerciseAngina!,
                                                    stSlope!,
                                                    restingBP!,
                                                    cholesterol!,
                                                    maxHR!,
                                                    oldpeak!,
                                                    double.parse(predRounded),
                                                    '',
                                                    title));
                                              },
                                              child: Text('Save'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text('Save As New Profile'),
                                ),
                              ],
                            );
                          });
                    }
                  },
                  child: Text('Save Details'),
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
                              color: Color.fromARGB(255, 21, 107, 176),
                              width: 1),
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
                              color: Color.fromARGB(255, 21, 107, 176),
                              width: 1),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HealthPage()));
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
            SizedBox(height: 100),
            Text(
              'Please note that this value is based on an ML model and is not entirely reliable. Contact a doctor for accurate results.',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.red,
                shadows: const [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(0.1, 0.3), // Set shadow offset
                    blurRadius: 0, // Set shadow blur radius
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _save(Detail detail) async {
    //Navigator.pop(context);
    detail.date = DateFormat.yMMMd().format(DateTime.now());
    int result = await databaseHelper.insertDetail(detail);

    if (result != 0) {
      _showAlertDialog('Status', 'Note Saved Successfully!');
    } else {
      _showAlertDialog('Status', 'Error Saving Note!');
    }
  }

  void _update(Detail detail) async {
    detail.date = DateFormat.yMMMd().format(DateTime.now());
    int result = await databaseHelper.updateDetail(detail);

    if (result != 0) {
      _showAlertDialog('Status', 'Note Updated Successfully!');
    } else {
      _showAlertDialog('Status', 'Error Saving Note!');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }
}
