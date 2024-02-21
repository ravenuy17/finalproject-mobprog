import 'package:flutter/material.dart';
import 'package:flutter_application_5_experiment/constant.dart';

class ResultMessage extends StatelessWidget {
  final String message;
  final VoidCallback onTap;
  final icon;

  const ResultMessage(
      {Key? key,
      required this.message,
      required this.onTap,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellowAccent,
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              message,
              style: blackTextStyle,
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.lightGreenAccent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(Icons.arrow_forward, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
