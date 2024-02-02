import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Number pad list
  static const List<String> numberPad = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    'DEL',
    '1',
    '2',
    '3',
    '=',
    '0'
  ];

  // NumA and NumB
  int numberA = 1;
  int numberB = 1;

  // User answer
  String userAnswer = '';

  // Button tapped
  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        // Calculate the result
        checkResult();
      } else if (button == 'C') {
        // Clear input
        userAnswer = '';
      } else if (button == 'DEL') {
        // Delete last number
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (userAnswer.length < 5) {
        userAnswer += button;
      }
    });
  }

  // Check result
  void checkResult() {
    if (numberA + numberB == int.parse(userAnswer)) {
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
                  Text('Great job!', style: TextStyle(color: Colors.white)),
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

  // Go to next question
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent[100],
      body: Column(
        children: <Widget>[
          // Level progress
          Container(height: 100, color: Colors.amber),
          // Questions
          Expanded(
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        '$numberA + $numberB =',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // Answer box
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
            ),
          ),
          // Number pad
          Expanded(
            flex: 3,
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
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final String child;
  final VoidCallback onTap;

  const MyButton({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            child,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
