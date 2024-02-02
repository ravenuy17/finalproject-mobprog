import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_application_5_experiment/constant.dart';
import 'package:flutter_application_5_experiment/util/numKey.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Number pad list
  List<String> numberPad = [
    "7",
    "8",
    "9",
    "C",
    "4",
    "5",
    "6",
    "DEL",
    "1",
    "2",
    "3",
    "=",
    "0",
  ];

  // Question variables
  int numberA = 1;
  int numberB = 1;
  String operator = '+';

  // User's answer
  String userAnswer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        children: [
          // Level progress, get 5 to proceed to the next level
          Container(
            height: 100,
            color: Colors.amberAccent,
          ),
          // Question
          Expanded(
            child: Container(
              child: Center(
                child: Text(
                  '$numberA $operator $numberB = $userAnswer',
                  style: whiteTextStyle,
                ),
              ),
              color: Colors.blue,
            ),
          ),

          // Number pad
          Expanded(
            flex: 3,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: GridView.builder(
                  itemCount: numberPad.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (context, index) {
                    return MyButton(
                      child: numberPad[index],
                      onTap: () => buttonTapped(numberPad[index]),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Button tapped function
  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        // Calculate result
        checkResult();
      } else if (button == 'C') {
        // Clear input
        userAnswer = '';
      } else if (button == 'DEL') {
        // Delete last number
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else {
        // Append the button value to the user's answer
        userAnswer += button;
      }
    });
  }

  // Check result function
  void checkResult() {
    int result = operator == '+'
        ? numberA + numberB
        : 0; // You can expand this for other operators

    if (result == int.parse(userAnswer)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.blueGrey,
            content: Container(
              height: 250,
              color: Colors.blueGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Great job!', style: whiteTextStyle),
                  GestureDetector(
                    onTap: goToNextQuestion,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      print('Try again!');
    }
  }

  // Go to next question function
  void goToNextQuestion() {
    // Dismiss alert
    Navigator.of(context).pop();

    // Reset values
    setState(() {
      userAnswer = '';
    });

    // Create new question
    numberA = Random().nextInt(1000);
    numberB = Random().nextInt(1000);
  }
}
