//ignore_for_file: prefer_const_constructors
import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  bool isclicked = false;
  final List<String> categories = [
    'High Cholesterol',
    'High Blood Pressure (Hypertension)',
    'High Blood Sugar (Hyperglycemia)',
    'Low Blood Sugar (Hypoglycemia)',
    'Low Heart Rate (Bradycardia)',
    'High Heart Rate (Tachycardia)'
  ];

  String chosenCategory = '';
  final Map<String, String> data = {
    'High Cholesterol': 'Prevention:'
        '\n-> Choose foods that are low in saturated fat, trans fat, sodium (salt), and added sugars.'
        '\n-> Eat foods naturally high in fiber'
        '\n-> Maintain a healthy BMI'
        '\n-> Get regular physical activity'
        '\n-> Quit smoking and alcohol'
        '\n\nTreatment/Management:'
        '\n-> Take medicines as directed'
        '\n-> Make healthy lifestyle changes'
        '\n-> Work cooperatively with a medical team'
        '\n-> Regularly check cholesterol levels'
        '\n\nDiseases linked:'
        '\n-> Coronary heart disease'
        '\n-> Stroke'
        '\n-> Hypertension'
        '\n-> Diabetes',
    'High Blood Pressure (Hypertension)': 'Treatment/Management:'
        '\n-> Reduce salt consumption'
        '\n-> Increase intake of potassium'
        '\n-> Limit alcohol'
        '\n-> Get regular physical exercise'
        '\n-> Follow a balanced diet'
        '\n\nDiseases linked:'
        '\n-> Coronary artery disease (CAD)'
        '\n-> Heart attack'
        '\n-> Stroke'
        '\n-> Peripheral artery disease'
        '\n-> Kidney damage/failure',
    'High Blood Sugar (Hyperglycemia)': 'Prevention:'
        '\n-> Take all your medications as prescribed.'
        '\n-> Follow your healthcare provider’s instructions about food and exercise.'
        '\n-> Check your blood sugar regularly.'
        '\n\nTreatment/Management:'
        '\n-> Following a balanced diet'
        '\n-> Limiting alcohol'
        '\n-> Cutting down on blood sugar'
        '\n-> Oral medications or injected insulin, if prescribed'
        '\n\nDiseases linked:'
        '\n-> Heart disease'
        '\n-> Gastroparesis'
        '\n-> Retinopathy'
        '\n-> Stroke'
        '\n-> Nephropathy',
    'Low Blood Sugar (Hypoglycemia)': 'Prevention:'
        '\n-> Take all your medications exactly as prescribed.'
        '\n-> Follow your healthcare provider’s instructions about food and exercise.'
        '\n-> Use a continuous glucose monitor (CGM) or check your blood sugar regularly, including before and after meals, before and after exercise and before bed.'
        '\n-> After you’ve treated a low blood sugar episode, write down the details of the episode. Include details such as the time, what you ate recently, whether you exercised, the symptoms and your glucose level. This can help you and your provider adjust your management plan to try and prevent future lows.'
        '\n\nTreatment/Management:'
        '\n-> 15-15 rule:  Eat or drink 15 grams of fast-acting carbs to raise your blood sugar.'
        '\n- After 15 minutes, check your blood sugar.'
        '\n- If it’s still below 70 mg/dL, have another 15 grams of fast-acting carbs.'
        '\n- Repeat until your blood sugar is at least 70 mg/dL.'
        '\n-> Severe episode: Use external glucagon and either use the glucagon nasal spray or inject it immediately into the patient’s arm or thigh. Do not give them food or liquid as they could choke.'
        '\n\nDiseases linked:'
        '\n-> Multiple organ failure'
        '\n-> Cardiac arrhythmias'
        '\n-> Cardiac arrest'
        '\n-> Permanent brain damage',
    'Low Heart Rate (Bradycardia)': 'Treatment/Management:'
        '\n-> External prescribed medication'
        '\n-> Temporary pacing of the heart using mild electrical currents'
        '\n-> Permanent pacemaker'
        '\n\nDiseases linked:'
        '\n-> Heart block'
        '\n-> Hypothroidism'
        '\n-> Sick sinus syndrome (SSS)'
        '\n-> Electrolyte imbalances',
    'High Heart Rate (Tachycardia)': 'Treatment/Management:'
        '\n-> Cardioversion'
        '\n-> External prescribed medicines'
        '\n-> Reducing intake of caffeine and alcohol'
        '\n\nDiseases linked:'
        '\n-> Atrial fibrillation'
        '\n-> Supraventricular Tachycardia'
        '\n-> Anemia'
        '\n-> Heart failure'
        '\n-> Pulmonary embolism'
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Health Recommendations',
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
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: paramDecoration(),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Category:',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 250,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        decoration: decorationfunction(),
                        hint: Text('Choose an option',
                            style: TextStyle(fontSize: 18)),
                        items: categories.map((paintype) {
                          return DropdownMenuItem<String>(
                            value: paintype,
                            child: Text(
                              paintype,
                              style: TextStyle(fontSize: 17),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) => setState(
                          () {
                            chosenCategory = val!;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              if (chosenCategory != '')
                Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: paramDecoration(),
                      child: Text(
                        data[chosenCategory]!,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      // decoration: paramDecoration(),
                      child: Text(
                        'Please note that these are generic recommendations and are not entirely reliable. Contact a doctor for personalised feedback.',
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
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
