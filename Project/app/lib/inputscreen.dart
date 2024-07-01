//ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:app/constants.dart';
import 'package:app/detail.dart';
import 'package:flutter/material.dart';
import 'predictionscreen.dart';
import 'mapping.dart' as mapfile;

class InputScreen extends StatefulWidget {
  bool edit = false;
  late Detail detail;
  InputScreen({required this.edit, required this.detail}) : super();

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  bool flag = false;
  bool edit_curr = true;
  int age = -1;
  int? sex, chestPainType, fastingBS = -1, restingECG, exerciseAngina, stSlope;
  double? restingBP = -1,
      cholesterol = -1,
      maxHR = -1,
      fastingBSTemp = -1,
      oldpeak;

  //keep in mind that the mapping needs to be changed later as the
  //model columns mapping is not correct
  final List<String> chestPainData = [
    'ASY: Asymptomatic',
    'NAP: Non-Anginal Pain',
    'ATA: Atypical Angina',
    'TA: Typical Angina',
  ];

  final Map<String, int> chestPainInt = {
    'ASY: Asymptomatic': 0,
    'NAP: Non-Anginal Pain': 2,
    'ATA: Atypical Angina': 1,
    'TA: Typical Angina': 3,
  };

  final List<String> restingECGOptions = ['Normal', 'ST', 'LVH'];
  @override
  Widget build(BuildContext context) {
    bool edit = widget.edit;
    Detail detail = widget.detail;

    if (edit_curr) {
      age = detail.age;
      sex = detail.sex;
      chestPainType = detail.chestPainType;
      fastingBS = detail.fastingBS;
      fastingBSTemp = detail.fastingBSTemp;
      restingECG = detail.restingECG;
      exerciseAngina = detail.exerciseAngina;
      stSlope = detail.stSlope;
      restingBP = detail.restingBP;
      cholesterol = detail.cholesterol;
      maxHR = detail.maxHR;
      oldpeak = detail.oldpeak;

      setState(() {
        edit_curr = false;
      });
    }
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Input Data',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                // color: Colors.white,
                decoration: paramDecoration(),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Age',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        explainTerm(
                            context, 'Age', 'Age of the user, in years');
                      },
                      child: Icon(
                        Icons.help_outline_rounded,
                        size: 17,
                        color: Colors.grey,
                      ), // Icon to show dialog
                    ),
                    Container(
                      width: 250,
                      child: Slider(
                        value: age == -1 ? 0 : age.toDouble(),
                        min: 0,
                        max: 100,
                        divisions: 101,
                        onChanged: (val) => setState(() {
                          age = val.toInt();
                          print(age);
                        }),
                        activeColor: Colors.pink,
                        inactiveColor: const Color.fromARGB(255, 255, 199, 218),
                      ),
                    ),
                    Text(
                      age == -1 ? 0.toString() : age.toString(),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: paramDecoration(),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Sex',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        explainTerm(context, 'Sex', 'Sex of the user');
                      },
                      child: Icon(
                        Icons.help_outline_rounded,
                        size: 17,
                        color: Colors.grey,
                      ), // Icon to show dialog
                    ),
                    Radio(
                      value: 1,
                      groupValue: edit_curr ? detail.sex.toInt() : sex,
                      onChanged: (value) {
                        setState(() {
                          sex = value;
                          // print(sex);
                        });
                      },
                      activeColor: Colors.pink,
                    ),
                    Text('Male'),
                    SizedBox(width: 30),
                    Radio(
                      value: 0,
                      groupValue: edit_curr ? detail.sex.toInt() : sex,
                      onChanged: (value) {
                        setState(() {
                          sex = value;
                          // print(sex);
                        });
                      },
                      activeColor: Colors.pink,
                    ),
                    Text('Female'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: paramDecoration(),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Chest Pain Type',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        explainTerm(context, 'Chest Pain Type',
                            'Chest pain type of user');
                      },
                      child: Icon(
                        Icons.help_outline_rounded,
                        size: 17,
                        color: Colors.grey,
                      ), // Icon to show dialog
                    ),
                    SizedBox(width: 52),
                    Container(
                      width: 138,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        decoration: decorationfunction(),
                        value: !edit_curr
                            ? mapfile
                                .chestPainTypeVals[detail.chestPainType.toInt()]
                            : null,
                        hint: Text('Choose an option',
                            style: TextStyle(fontSize: 15)),
                        items: chestPainData.map((paintype) {
                          return DropdownMenuItem<String>(
                            value: paintype,
                            child: Text(
                              paintype,
                              style: TextStyle(fontSize: 13),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() {
                          chestPainType = chestPainInt[val];
                          // print(chestPainType);
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: paramDecoration(),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Resting BP',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        explainTerm(context, 'Resting BP',
                            'Resting blood pressure [mm Hg]');
                      },
                      child: Icon(
                        Icons.help_outline_rounded,
                        size: 17,
                        color: Colors.grey,
                      ), // Icon to show dialog
                    ),
                    SizedBox(width: 92),
                    Container(
                      width: 138,
                      child: TextFormField(
                        initialValue: (!edit_curr && detail.restingBP == -1)
                            ? null
                            : !edit_curr
                                ? detail.restingBP.toString()
                                : null,
                        decoration: decorationfunction('In mm Hg'),
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter a value' : null,
                        onChanged: (val) =>
                            setState(() => restingBP = double.parse(val)),
                        onEditingComplete: () {
                          if (restingBP != null) {
                            if (restingBP! < 65 || restingBP! > 185) {
                              _showSnackBar(context,
                                  'Error! Must be between 65 and 185!');
                              FocusScope.of(context).unfocus();
                            } else {
                              FocusScope.of(context).unfocus();
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: paramDecoration(),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Cholesterol',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        explainTerm(context, 'Cholesterol',
                            'Serum cholesterol [mm/dl]');
                      },
                      child: Icon(
                        Icons.help_outline_rounded,
                        size: 17,
                        color: Colors.grey,
                      ), // Icon to show dialog
                    ),
                    SizedBox(width: 89),
                    Container(
                      width: 136,
                      child: TextFormField(
                          initialValue: (!edit_curr && detail.cholesterol == -1)
                              ? null
                              : !edit_curr
                                  ? detail.cholesterol.toString()
                                  : null,
                          decoration: decorationfunction('In mm/dl'),
                          validator: (val) =>
                              val!.isEmpty ? 'Please enter a value' : null,
                          onChanged: (val) =>
                              setState(() => cholesterol = double.parse(val)),
                          onEditingComplete: () {
                            if (cholesterol != null) {
                              if (cholesterol! < 100 || cholesterol! > 320) {
                                _showSnackBar(context,
                                    'Error! Must be between 100 and 320!');
                                FocusScope.of(context).unfocus();
                              } else {
                                FocusScope.of(context).unfocus();
                              }
                            }
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: paramDecoration(),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Fasting Blood Sugar',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        explainTerm(context, 'Fasting Blood Sugar',
                            'Fasting blood sugar [mg/dl]');
                      },
                      child: Icon(
                        Icons.help_outline_rounded,
                        size: 17,
                        color: Colors.grey,
                      ), // Icon to show dialog
                    ),
                    SizedBox(width: 22),
                    Container(
                      width: 134,
                      child: TextFormField(
                        initialValue: (!edit_curr && detail.fastingBSTemp == -1)
                            ? null
                            : !edit_curr
                                ? detail.fastingBSTemp.toString()
                                : null,
                        decoration: decorationfunction('In mg/dl'),
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter a value' : null,
                        onChanged: (val) => setState(() {
                          fastingBS = double.parse(val) > 120.0 ? 1 : 0;
                          fastingBSTemp = double.parse(val);

                          // print(fastingBS);
                        }),
                        onEditingComplete: () {
                          if (fastingBSTemp != null) {
                            if (fastingBSTemp! < 50 || fastingBSTemp! > 150) {
                              _showSnackBar(context,
                                  'Error! Must be between 50 and 150!');
                              FocusScope.of(context).unfocus();
                            } else {
                              FocusScope.of(context).unfocus();
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(5),
                decoration: paramDecoration(),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Resting ECG',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        explainTerm(context, 'Resting ECG',
                            "Resting electrocardiogram results-\nNormal: Normal\nST: having ST-T wave abnormality (T wave inversions and/or ST elevation or depression of > 0.05 mV)\nLVH: showing probable or definite left ventricular hypertrophy by Estes' criteria");
                      },
                      child: Icon(
                        Icons.help_outline_rounded,
                        size: 17,
                        color: Colors.grey,
                      ), // Icon to show dialog
                    ),
                    Radio(
                      value: 1,
                      groupValue: edit_curr ? detail.restingECG : restingECG,
                      onChanged: (value) {
                        setState(() {
                          restingECG = value;
                          // print(sex);
                        });
                      },
                      activeColor: Colors.pink,
                    ),
                    Text('Normal'),
                    SizedBox(width: 0),
                    Radio(
                      value: 2,
                      groupValue: edit_curr ? detail.restingECG : restingECG,
                      onChanged: (value) {
                        setState(() {
                          restingECG = value;
                          // print(sex);
                        });
                      },
                      activeColor: Colors.pink,
                    ),
                    Text('ST'),
                    SizedBox(width: 0),
                    Radio(
                      value: 0,
                      groupValue: edit_curr ? detail.restingECG : restingECG,
                      onChanged: (value) {
                        setState(() {
                          restingECG = value;
                        });
                      },
                      activeColor: Colors.pink,
                    ),
                    Text('LVH'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: paramDecoration(),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Max Heart Rate',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        explainTerm(context, 'Max Heart Rate',
                            'Maximum heart rate achieved');
                      },
                      child: Icon(
                        Icons.help_outline_rounded,
                        size: 17,
                        color: Colors.grey,
                      ), // Icon to show dialog
                    ),
                    SizedBox(width: 60),
                    Container(
                      width: 132,
                      child: TextFormField(
                        decoration: decorationfunction('In bpm'),
                        initialValue: (!edit_curr && detail.maxHR == -1)
                            ? null
                            : !edit_curr
                                ? detail.maxHR.toString()
                                : null,
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter a value' : null,
                        onChanged: (val) =>
                            setState(() => maxHR = double.parse(val)),
                        onEditingComplete: () {
                          if (maxHR != null) {
                            if (maxHR! < 60 || maxHR! > 202) {
                              _showSnackBar(context,
                                  'Error! Must be between 60 and 202!');
                              FocusScope.of(context).unfocus();
                            } else {
                              FocusScope.of(context).unfocus();
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: paramDecoration(),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Exercise-induced Angina',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        explainTerm(context, 'Exercise-induced Angina',
                            'Exercise-induced Angina');
                      },
                      child: Icon(
                        Icons.help_outline_rounded,
                        size: 17,
                        color: Colors.grey,
                      ), // Icon to show dialog
                    ),
                    Radio(
                      value: 1,
                      groupValue: edit_curr
                          ? detail.exerciseAngina.toInt()
                          : exerciseAngina,
                      onChanged: (value) {
                        setState(() {
                          exerciseAngina = value;
                          // print(sex);
                        });
                      },
                      activeColor: Colors.pink,
                    ),
                    Text('Yes'),
                    SizedBox(width: 0),
                    Radio(
                      value: 0,
                      groupValue: edit_curr
                          ? detail.exerciseAngina.toInt()
                          : exerciseAngina,
                      onChanged: (value) {
                        setState(() {
                          exerciseAngina = value;
                          // print(sex);
                        });
                      },
                      activeColor: Colors.pink,
                    ),
                    Text('No'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: paramDecoration(),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Oldpeak',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        explainTerm(context, 'Oldpeak',
                            'Refers to an electrocardiographic (ECG) parameter known as the ST segment.\nThe ST segment is a portion of the ECG waveform that represents the interval between ventricular depolarization and repolarization.');
                      },
                      child: Icon(
                        Icons.help_outline_rounded,
                        size: 17,
                        color: Colors.grey,
                      ), // Icon to show dialog
                    ),
                    SizedBox(width: 117),
                    Container(
                      width: 132,
                      child: TextFormField(
                        decoration: decorationfunction('--'),
                        initialValue: (!edit_curr && detail.oldpeak == -1000)
                            ? null
                            : !edit_curr
                                ? detail.oldpeak.toString()
                                : null,
                        //decoration: InputDecoration(hintText: 'In mm Hg'),
                        validator: (val) =>
                            val!.isEmpty ? 'Please enter a value' : null,
                        onChanged: (val) =>
                            setState(() => oldpeak = double.parse(val)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: paramDecoration(),
                child: Row(
                  children: <Widget>[
                    Text(
                      'ST Slope',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        explainTerm(context, 'ST Slope',
                            'The slope of the peak exercise ST segment-\nUp: upsloping\nFlat: flat\nDown: downsloping');
                      },
                      child: Icon(
                        Icons.help_outline_rounded,
                        size: 17,
                        color: Colors.grey,
                      ), // Icon to show dialog
                    ),
                    Radio(
                      value: 2,
                      groupValue: edit_curr ? detail.stSlope : stSlope,
                      onChanged: (value) {
                        setState(() {
                          stSlope = value;
                          // print(sex);
                        });
                      },
                      activeColor: Colors.pink,
                    ),
                    Text('Up'),
                    SizedBox(width: 5),
                    Radio(
                      value: 1,
                      groupValue: edit_curr ? detail.stSlope : stSlope,
                      onChanged: (value) {
                        setState(() {
                          stSlope = value;
                          // print(sex);
                        });
                      },
                      activeColor: Colors.pink,
                    ),
                    Text('Flat'),
                    SizedBox(width: 5),
                    Radio(
                      value: 0,
                      groupValue: edit_curr ? detail.stSlope : stSlope,
                      onChanged: (value) {
                        setState(() {
                          stSlope = value;
                        });
                      },
                      activeColor: Colors.pink,
                    ),
                    Text('Down'),
                  ],
                ),
              ),
              SizedBox(height: 20),
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
                  if (sex == null ||
                      chestPainType == null ||
                      fastingBS == null ||
                      fastingBSTemp == null ||
                      restingECG == null ||
                      exerciseAngina == null ||
                      stSlope == null ||
                      restingBP == null ||
                      cholesterol == null ||
                      maxHR == null ||
                      oldpeak == null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error!'),
                          content: Text('Kindly fill in all data'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Close the dialog
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  } else if ((restingBP! < 65) ||
                      (restingBP! > 185) ||
                      (cholesterol! < 100) ||
                      (cholesterol! > 320) ||
                      (fastingBSTemp! < 50) ||
                      (fastingBSTemp! > 150) ||
                      (maxHR! < 60) ||
                      (maxHR! > 202)) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error!'),
                          content: Text('Values out of range!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Close the dialog
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    print(fastingBSTemp);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PredictionScreen(
                            age: age,
                            sex: sex,
                            chestPainType: chestPainType,
                            fastingBS: fastingBS,
                            fastingBSTemp: fastingBSTemp,
                            restingECG: restingECG,
                            exerciseAngina: exerciseAngina,
                            stSlope: stSlope,
                            restingBP: restingBP,
                            cholesterol: cholesterol,
                            maxHR: maxHR,
                            oldpeak: oldpeak,
                            edit: edit,
                            detail: detail),
                      ),
                    );
                  }
                },
                child: Text('Get Prediction'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
        content: Text(
      message,
      style: TextStyle(fontSize: 20),
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void explainTerm(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: Text(
            description,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
