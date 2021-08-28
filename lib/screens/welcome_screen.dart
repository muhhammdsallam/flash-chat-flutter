import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/button_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/components/curve_shape.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation1;
  Animation animation2;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation1 = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation2 = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    Firebase.initializeApp();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF006BFF),
      body: Column(
        children: [
          Expanded(
              child: Stack(fit: StackFit.expand, children: [
            Container(
              child: CurveShape(
                isWelcomePage: true,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  scale: 1.4,
                  image: AssetImage('images/speech-bubble.png'),
                  //fit: BoxFit.fill,
                ),
              ),
            )
          ])),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'TeamChat',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Simple. Secure. Reliable messaging.',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'With TeamChat, you will get fast, simple, secure messaging for free.',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(
                  height: 50.0,
                ),
                ButtonWidget(
                    label: 'Log in',
                    textColor: Colors.blue.shade800,
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    }),
                ButtonWidget(
                    label: 'Sign up',
                    textColor: Colors.white,
                    color: Color(0xFF006BFF),
                    onPressed: () {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    }),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
