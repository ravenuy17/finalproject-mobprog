import 'package:flutter/material.dart';
import 'package:flutter_application_5_experiment/addition.dart';
import 'package:flutter_application_5_experiment/division.dart';
import 'package:flutter_application_5_experiment/multiplication.dart';
import 'package:flutter_application_5_experiment/subtraction.dart';
import 'addition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdditionEasy(),
    );
  }
}
