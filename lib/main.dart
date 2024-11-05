import 'package:flutter/material.dart';
import 'landingscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial Tracker',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const FinancialTrackerScreen(),
    );
  }
}
