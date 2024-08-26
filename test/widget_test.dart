import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_form/BMI.dart'; // แทนที่ด้วยเส้นทางที่ถูกต้อง
import 'package:test_form/main.dart'; // แทนที่ด้วยเส้นทางที่ถูกต้อง

void main() {
  testWidgets('Test MyHomePage widget', (WidgetTester tester) async {
    // Build the MyHomePage widget
    await tester.pumpWidget(const MyApp());

    // Verify that the title and button are present
    expect(find.text('Flutter Form Navigation'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Tap the button and trigger a frame
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verify that we have navigated to the BMIScreen
    expect(find.text('Your Body Information'), findsOneWidget);
  });

  testWidgets('Test BMIScreen widget', (WidgetTester tester) async {
    // Build the BMIScreen widget
    await tester.pumpWidget(const MaterialApp(
      home: BMIScreen(),
    ));

    // Verify that the title and fields are present
    expect(find.text('Your Body Information'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));

    // Input weight and height
    await tester.enterText(find.byType(TextFormField).first, '70');
    await tester.enterText(find.byType(TextFormField).at(1), '175');

    // Tap the submit button
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    // Verify that the BMI result dialog appears
    expect(find.textContaining('Your BMI is'), findsOneWidget);
    expect(find.text('Status: Healthy weight'), findsOneWidget);
  });

  testWidgets('Test BMI calculation validation', (WidgetTester tester) async {
    // Build the BMIScreen widget
    await tester.pumpWidget(const MaterialApp(
      home: BMIScreen(),
    ));

    // Input invalid weight and height
    await tester.enterText(find.byType(TextFormField).first, '-70');
    await tester.enterText(find.byType(TextFormField).at(1), '95');

    // Tap the submit button
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    // Verify that the error message appears for weight
    expect(find.text('Required number more than zero!'), findsOneWidget);
  });
}
