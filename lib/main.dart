import 'package:flutter/material.dart';
import 'BMI.dart'; // ตรวจสอบว่าเส้นทางถูกต้อง

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning Flutter',
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Form Navigation'),
        '/pg1': (context) => const BMIScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 0, 0, 0)),
        ),
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
          Center(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.account_circle,
                                size: 30,
                                color: Color.fromARGB(255, 198, 9, 9)),
                            SizedBox(width: 20),
                            Text(
                              'Body Mass Index',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Color.fromARGB(255, 224, 9, 163)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 37, 217, 237),
                      elevation: 0, // Shadow scale
                    ),
                    child: const Text(
                      'Go to Page BMI',
                      style: TextStyle(
                          fontSize: 25, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/pg1');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
