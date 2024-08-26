import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'validators.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({Key? key}) : super(key: key);

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  double _weight = 0, _height = 0;
  final _formKey = GlobalKey<FormState>();

  void _calculateBMI() {
    if (_height <= 0) return;

    // Height in meters
    final heightInMeters = _height / 100;
    final bmi = _weight / (heightInMeters * heightInMeters);
    String bmiStatus;

    if (bmi < 18.5) {
      bmiStatus = 'Underweight';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      bmiStatus = 'Healthy weight';
    } else if (bmi >= 25 && bmi <= 29.9) {
      bmiStatus = 'Overweight';
    } else {
      bmiStatus = 'Obesity';
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('BMI Result'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                //.toStringAsFixed(2) ทำหน้าที่แปลงค่าของตัวแปร เป็น string และกำหนดให้ทศนิยมเหลือ2ตำแหน่ง'
                Text('Your BMI is ${bmi.toStringAsFixed(2)}'),
                Text('Status: $bmiStatus'),
              ],
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Body Information'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/clearsky.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  //ตกแต่ง weight text 
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Row(
                      /*mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,*/
                      children: [
                        Icon(Icons.line_weight_rounded, size: 35),
                        Text(
                          'Your Weight(km.)',
                          style:
                              TextStyle(color: Color.fromARGB(255, 26, 4, 227)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.-]')),
                      ],
                      
                      decoration: InputDecoration(
                        labelText: 'Weight(Kg.)',
                        labelStyle: TextStyle(color: Color.fromARGB(255, 199, 4, 102)),
                        hintText: 'Input your weight to calculate BMI',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (value) {
                        try {
                          _weight = double.parse(value);
                        } catch (e) {
                          _weight = 0;
                        }
                      },
                      validator: Validators.compose([
                        Validators.required('Required number [0-9]'),
                        Validators.min(0, 'Required number more than zero!')
                      ]),
                    ),
                  ),
                  //ตกแต่ง height text 
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Row(
                      /*mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,*/
                      children: [
                        Icon(Icons.height_rounded, size: 35),
                        Text(
                          'Your Height(Cm.)',
                          style: TextStyle(color: Colors.amber),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.-]')),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Height(Cm.)',
                        labelStyle: TextStyle(color: Color.fromARGB(255, 199, 4, 102)),
                        hintText: 'Input your height in centimeters',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (value) {
                        try {
                          _height = double.parse(value);
                        } catch (e) {
                          _height = 0;
                        }
                      },
                      validator: Validators.compose([
                        Validators.required('Required number [0-9]'),
                        Validators.min(100, 'Required number more than 100 CM!')
                      ]),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 2, 166, 38)),
                            ),
                            child: const Text('Submit'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _calculateBMI();
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                            ),
                            child: const Text('Close'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
