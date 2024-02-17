import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_application_5_experiment/constant.dart';
import 'package:flutter_application_5_experiment/util/numKey.dart';
import 'package:flutter_application_5_experiment/util/result.dart';

class AdditionEasy extends StatefulWidget {
  const AdditionEasy({Key? key}) : super(key: key);

  @override
  State<AdditionEasy> createState() => _AdditionEasyState();
}

class _AdditionEasyState extends State<AdditionEasy> {
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
// addends
  int numberA = Random().nextInt(10);
  int numberB = Random().nextInt(10);
  //sum or user answer
  String userAnswer = '';
  void checkResult() {
    if (numberA + numberB == int.parse(userAnswer)) {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: 'Great job!',
              onTap: () => goToNextQuestion(context),
              icon: Icons.arrow_forward,
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: 'Sorry try again',
              onTap: () => goBackToQuestion(context),
              icon: Icons.rotate_left,
            );
          });
    }
  }

  //tap button
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

    numberA = randomNumber.nextInt(10);
    numberB = randomNumber.nextInt(10);
  }

  void goBackToQuestion(BuildContext context) {
    Navigator.of(context).pop();
    setState(() {
      userAnswer = '';
    });
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
                      numberA.toString() + ' + ' + numberB.toString() + ' = ',
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
