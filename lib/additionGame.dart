import 'package:flutter/material.dart';
import 'dart:math';

class AdditionGame extends StatefulWidget {
  const AdditionGame({Key? key}) : super(key: key);
  @override
  _AdditionGameState createState() => _AdditionGameState();
}

class _AdditionGameState extends State<AdditionGame> {
  int numberA = Random().nextInt(10);
  int numberB = Random().nextInt(10);
  List<int> options = [];
  int correctAnswerIndex = 0;
  int correctAnswersCount = 0;
  int lives = 3;
  bool showCongratulations = false;
  void generateNewProblem() {
    setState(() {
      numberA = Random().nextInt(10);
      numberB = Random().nextInt(10);
      options = generateOptions();
      correctAnswerIndex = options.indexOf(numberA + numberB);
    });
  }

  List<int> generateOptions() {
    int sum = numberA + numberB;
    int incorrectAnswer1 = Random().nextInt(20);
    int incorrectAnswer2 = Random().nextInt(20);
    while (incorrectAnswer1 == sum) {
      incorrectAnswer1 = Random().nextInt(20);
    }
    while (incorrectAnswer2 == sum || incorrectAnswer2 == incorrectAnswer1) {
      incorrectAnswer2 = Random().nextInt(20);
    }
    List<int> options = [sum, incorrectAnswer1, incorrectAnswer2];
    options.shuffle();
    return options;
  }

  void checkResult(int selectedAnswerIndex) {
    if (selectedAnswerIndex == correctAnswerIndex) {
      correctAnswersCount++;
      if (correctAnswersCount == 3) {
        setState(() {
          showCongratulations = true;
        });
      } else {
        generateNewProblem();
      }
    } else {
      setState(() {
        lives--;
        if (lives == 0) {
          _showGameOverDialog(context);
        } else {
          generateNewProblem();
        }
      });
      correctAnswersCount = 0;
    }
  }

  void _showGameOverDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Game Over"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("You ran out of lives. Try again!"),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Start a new game
                  setState(() {
                    lives = 3;
                    correctAnswersCount = 0;
                    showCongratulations = false;
                    generateNewProblem();
                  });
                },
                child: Text("Try Again"),
              ),
            ],
          ),
        );
      },
    );
  }

  void navigateBack() {
    Navigator.of(context).pop();
  }

  void exitGame() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    generateNewProblem();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exitGame();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          // Remove the title property
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: exitGame,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$numberA + $numberB = ?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => showCongratulations
                          ? navigateBack()
                          : checkResult(index),
                      child: Text(options[index].toString()),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  lives,
                  (index) => Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(height: 50),
              if (showCongratulations)
                Text(
                  'Congratulations! You answered 3 consecutive problems correctly!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
