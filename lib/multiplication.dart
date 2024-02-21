import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_application_5_experiment/constant.dart';
import 'package:flutter_application_5_experiment/util/numKey.dart';
import 'package:flutter_application_5_experiment/util/result.dart';

class Multiplication extends StatefulWidget {
  const Multiplication({Key? key}) : super(key: key);

  @override
  State<Multiplication> createState() => _Multiplication();
}

class _Multiplication extends State<Multiplication> {
  List<String> numPad = [
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
    '0',
    'Submit',
  ];
  // variables
  int numberA = 0;
  int numberB = 0;
  // difference or user answer
  String userAnswer = '';

  void generateNumbers() {
    numberA = randomNumber.nextInt(50);
    numberB = randomNumber.nextInt(50);
  }

  void checkResult() {
    try {
      int userAnswerInt = int.parse(userAnswer);

      if (numberA * numberB == userAnswerInt) {
        showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: 'Great job!',
              onTap: () => goToNextQuestion(context),
              icon: Icons.arrow_forward,
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: 'Sorry, try again',
              onTap: () => goBackToQuestion(context),
              icon: Icons.rotate_left,
            );
          },
        );
      }
    } catch (e) {
      // Handle parsing errors
      showDialog(
        context: context,
        builder: (context) {
          return ResultMessage(
            message: 'Invalid input! Please enter a number.',
            onTap: () {
              Navigator.of(context).pop();
            },
            icon: Icons.warning,
          );
        },
      );
    }
  }

  // tap button
  void buttonTap(String button) {
    setState(() {
      if (button == 'Submit') {
        checkResult();
      } else if (button == 'C') {
        userAnswer = '';
      } else if (button == 'DEL') {
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (userAnswer.length < 4) {
        userAnswer += button;
      }
    });
  }

  var randomNumber = Random();

  void goToNextQuestion(BuildContext context) {
    Navigator.of(context).pop();

    setState(() {
      userAnswer = '';
    });

    generateNumbers();
  }

  void goBackToQuestion(BuildContext context) {
    Navigator.of(context).pop();
    setState(() {
      userAnswer = '';
    });

    generateNumbers();
  }

  @override
  void initState() {
    super.initState();
    generateNumbers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[300],
      body: Column(
        children: [
          Container(
            height: 160,
            color: Colors.deepOrangeAccent,
          ),
          Expanded(
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$numberA * $numberB = ',
                      style: whiteTextStyle,
                    ),
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[400],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          userAnswer,
                          style: defaultTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: GridView.builder(
                itemCount: numPad.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  return MyButton(
                    child: numPad[index],
                    onTap: () => buttonTap(numPad[index]),
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
