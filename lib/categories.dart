import 'package:flutter/material.dart';
import 'addition.dart';
import 'additionGame.dart';
import 'subtraction.dart';
import 'multiplication.dart';
import 'division.dart';
import 'homepage.dart';

void main() {
  runApp(categories());
}

class categories extends StatelessWidget {
  const categories({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CategoriesScreen(),
    );
  }
}

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Four Button Options'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FancyButtonOption('Addition', 'Pressed Button 1', AdditionGame()),
              SizedBox(height: 16),
              FancyButtonOption(
                  'Subtraction', 'Pressed Button 2', Subtraction()),
              SizedBox(height: 16),
              FancyButtonOption(
                  'Multiplication', 'Pressed Button 3', Multiplication()),
              SizedBox(height: 16),
              FancyButtonOption('Division', 'Pressed Button 4', Division()),
              SizedBox(height: 16),
              // Close Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Homepage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // You can customize the color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: Text(
                  'Close',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FancyButtonOption extends StatefulWidget {
  final String buttonText;
  final String message;
  final Widget nextScreen;

  FancyButtonOption(this.buttonText, this.message, this.nextScreen);

  @override
  _FancyButtonOptionState createState() => _FancyButtonOptionState();
}

class _FancyButtonOptionState extends State<FancyButtonOption> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        width: 250,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => widget.nextScreen),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: _isHovered ? Colors.blue : Colors.white,
            onPrimary: _isHovered ? Colors.white : Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          child: Text(
            widget.buttonText,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
