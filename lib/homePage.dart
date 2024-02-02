import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_5_experiment/constant.dart';
import 'package:flutter_application_5_experiment/util/numKey.dart';

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
    '0'
  ];
//numA and numB
  int numberA = 1;
  int numberB = 1;
  //user answer
  String userAnswer = '';

  //button tapped
  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        //calculate the ff.
        CheckResult();
      } else if (button == 'C') {
        // clear input
        userAnswer = '';
      } else if (button == 'DEL') {
        // delete last number
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (userAnswer.length < 5) {
        userAnswer += button;
      }
    });
  }

//uncommitted changes
  void CheckResult() {
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
                    Text('Great job!', style: whiteTextStyle),
                    //button to go to next question
                    GestureDetector(
                      onTap: goToNextQuestion,
                    ),
                    Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            );
          });
    } else {
      print('Try again!');
    }
  }

  //create random numbers
  var randomNumber = Random();

  void goToNextQuestion() {
    //dismiss alert
    Navigator.of(context).pop();

    //reset values
    setState(() {
      userAnswer = '';
    });

    //create new question
    numberA = randomNumber.nextInt(1000);
    numberB = randomNumber.nextInt(1000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent[100],
      body: Column(
        children: <Widget>[
          //level progress, needs 5 correct answers in a row to proceed to the next level
          Container(height: 100, color: Colors.amber),
          //questions
          Expanded(
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // question
                  children: [
                    Expanded(
                      child: Text(
                        numberA.toString() + '+' + numberB.toString() + '=',
                        style: defaultTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // answer box
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

          //number pad
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
