import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

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
  int numberA = Random().nextInt(1000);
  int numberB = Random().nextInt(1000);
  String operator = '+';

  // User's answer
  String userAnswer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            // Level progress, get 5 to proceed to the next level
            Container(
              height: 100,
              color: Colors.amberAccent,
            ),
            // Question
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Center(
                child: Text(
                  '$numberA $operator $numberB = $userAnswer',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              color: Colors.blue,
            ),

            // Number pad
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: GridView.builder(
                  itemCount: numberPad.length,
                  physics: NeverScrollableScrollPhysics(),
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

  void checkResult() {
    int result = numberA + numberB;
    if (int.tryParse(userAnswer) == result) {
      showGreatJobModal();
    } else {
      showTryAgainModal();
    }
  }

  void showGreatJobModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Great Job!'),
          content: Text('You got it right!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                generateNewQuestion();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showTryAgainModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Try Again'),
          content: Text('Oops! Your answer is incorrect. Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void generateNewQuestion() {
    setState(() {
      // Update question variables for a new question
      numberA = Random().nextInt(1000);
      numberB = Random().nextInt(1000);
      userAnswer = '';
    });
  }
}

class MyButton extends StatelessWidget {
  final String child;
  final VoidCallback onTap;

  MyButton({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          child,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
