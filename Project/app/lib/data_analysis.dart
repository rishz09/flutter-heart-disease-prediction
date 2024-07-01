//ignore_for_file: prefer_const_constructors
import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class DataAnalysisScreen extends StatefulWidget {
  const DataAnalysisScreen({super.key});

  @override
  State<DataAnalysisScreen> createState() => _DataAnalysisScreenState();
}

class _DataAnalysisScreenState extends State<DataAnalysisScreen> {
  final List<String> graphType = [
    'None',
    'Heart Disease vs Sex',
    'Heart Disease vs Chest Pain Type',
    'Heart Disease vs Exercise-induced Angina',
    'Heart Disease vs Resting ECG',
    'Heart Disease vs ST Slope'
  ];

  final Map<String, String> imgName = {
    'None': 'None',
    'Heart Disease vs Sex': 'sex_heartdisease.png',
    'Heart Disease vs Chest Pain Type': 'chestpaintype_heartdisease.png',
    'Heart Disease vs Exercise-induced Angina':
        'exerciseangina_heartdisease.png',
    'Heart Disease vs Resting ECG': 'restingecg_heartdisease.png',
    'Heart Disease vs ST Slope': 'stslope_heartdisease.png'
  };

  String imgfileName = 'None';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Visualisation',
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
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: paramDecoration(),
              child: Row(
                children: <Widget>[
                  Text(
                    'Choose Graph:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 220,
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: decorationfunction(),
                      value: 'None',
                      hint: Text('Choose an option'),
                      items: graphType.map((val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                      onChanged: (v) => setState(() {
                        imgfileName = imgName[v]!;
                      }),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: Container(
                width: 350,
                height: 350,
                decoration: paramDecoration(),
                // color: const Color.fromARGB(255, 245, 245, 245),
                child: Center(
                  child: (imgfileName != 'None')
                      ? Image.asset(
                          'assets/$imgfileName', // Path to your image asset
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : Text(
                          'Graphs will be displayed here',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
