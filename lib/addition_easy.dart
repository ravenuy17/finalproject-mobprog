import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_application_5_experiment/constant.dart';
import 'package:flutter_application_5_experiment/util/numKey.dart';
import 'package:flutter_application_5_experiment/util/result.dart';

class addition_easy extends StatefulWidget {
  const addition_easy({Key? key}) : super(key: key);

  @override
  State<addition_easy> createState() => _addition_easyState();
}

class _addition_easyState extends State<addition_easy> {
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
    '=',
    '0',
  ];
// addends
  int numberA = Random().nextInt(10);
  int numberB = Random().nextInt(10);
  //sum or user answer
  String userAnswer = '';

  //tap button
  void buttonTap(String button) {
    setState(() {
      if (button == '=') {
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

  void checkResult() {
    if (numberA + numberB == int.parse(userAnswer)) {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
              message: 'Good job!',
              onTap: goToNextQuestion,
              icon: Icons.arrow_forward,
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (Context) {
            return ResultMessage(
              message: 'Try again!',
              onTap: goBackToQuestion,
              icon: Icons.rotate_left,
            );
          });
    }
  }

  var randomNumber = Random();

  void goBackToQuestion() {
    Navigator.of(context).pop;
  }

  void goToNextQuestion() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[300],
      body: Column(children: [
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
                  )
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
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return MyButton(
                    child: numPad[index],
                    onTap: () => buttonTap(numPad[index]),
                  );
                }),
          ),
        )
      ]),
    );
  }
}
