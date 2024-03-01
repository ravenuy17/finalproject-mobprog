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

  int numberA = Random().nextInt(10);
  int numberB = Random().nextInt(10);
  String userAnswer = '';
  bool showInstructions = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showInstructionsDialog(context);
    });
  }

  void _showInstructionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Instructions"),
          content: Text(" -A random number will be generated on the screen."
              "\n -Players must solve the combination of numbers that sums up."
              "\n\t\t\t(For example: 579 + 238 = ???)\n -Players earn points for each correct answer.\n -Players can only exit the game after answering five consecutive RIGHT answers \n-The player with the highest total score after a set number of rounds wins the game."),
          actions: <Widget>[
            TextButton(
              child: Text("Got It"),
              onPressed: () {
                setState(() {
                  showInstructions = false;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
  }

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
      backgroundColor: Colors.blue[800],
      body: Column(
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepOrangeAccent, Colors.deepOrange],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                // You can add other widgets or text here as needed
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.deepPurpleAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      numberA.toString() + ' + ' + numberB.toString() + ' = ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Quicksand', // Use a stylish font
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[400],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          userAnswer,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                          ),
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
              padding: const EdgeInsets.all(10.0),
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
