import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'categories.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Math Mathinik'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('homepage/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Hero(
              tag: 'logo',
              child: Material(
                color: Colors.transparent,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.5, end: 1.0).animate(
                    CurvedAnimation(
                      parent: AlwaysStoppedAnimation(1),
                      curve: Curves.easeInOut,
                    ),
                  ),
                  child: Image.asset(
                    'homepage/logo.png',
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(
                    255, 255, 255, 255), // Adjust text color as needed
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText('Welcome to Math Mathinik'),
                  TyperAnimatedText('Where Math is Fun and Exciting'),
                ],
                totalRepeatCount: 10,
              ),
            ),
            // ... existing code ...

            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => categories()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Change the button color to white
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
