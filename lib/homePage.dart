import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_application_5_experiment/constant.dart';
import 'package:flutter_application_5_experiment/util/numKey.dart';
import 'package:flutter_application_5_experiment/util/result.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //number pad list
  List<String> numberPad = [
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
//numbers
  int numA = Random().nextInt(1000);
  int numB = Random().nextInt(1000);
  //user answer
  String userAnswer = '';

  //button tap
  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        checkResult();
      }
      //clear
      else if (button == 'C') {
        userAnswer = '';
        //delete last number
      } else if (button == 'DEL') {
        userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
        //max length
      } else if (userAnswer.length < 5) {
        userAnswer += button;
      }
    });
  }

//GO BACK TO QUESTION
  void goBackToQuestion() {
    //dismiss alert dialog
    Navigator.of(context).pop();
  }

  void goToNextQuestion() {
    setState(() {
      numA = Random().nextInt(1000);
      numB = Random().nextInt(1000);
      userAnswer = '';
    });
    Navigator.pop(context);
    setState(() {
      userAnswer = '';
    });
  }

  void checkResult() {
    if (numA + numB == int.parse(userAnswer)) {
      showDialog(
        context: context,
        builder: (context) {
          return ResultMessage(
              message: 'Great Job!',
              onTap: goToNextQuestion,
              icon: Icons.arrow_forward);
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return ResultMessage(
              message: 'Try again!',
              onTap: goBackToQuestion,
              icon: Icons.rotate_left);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        children: [
          Container(
            height: 100,
            color: Colors.amberAccent,
          ),

          //question
          Expanded(
            child: Container(
              color: Colors.deepOrangeAccent,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //question
                    //numA.toString() + " + " + numB.toString() + " = "
                    Text('$numA + $numB = ', style: defaultTextStyle),

                    //answer box
                    Container(
                      height: 80,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(userAnswer, style: whiteTextStyle),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          //number pad

          Expanded(
            flex: 3,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: GridView.builder(
                  itemCount: numberPad.length,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (context, index) {
                    return MyButton(
                      child: numberPad[index],
                      onTap: () => buttonTapped(numberPad[index]),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
