import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/button_widget.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'login_screen.dart';
import 'package:flash_chat/components/curve_shape.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'register';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  @override
  void dispose() {
    super.dispose();
  }

  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisible;
    isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          children: [
            Expanded(
                child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  child: CurveShape(
                    isWelcomePage: false,
                  ),
                ),
                Container(
                  decoration: isKeyboardVisible
                      ? null
                      : BoxDecoration(
                          image: DecorationImage(
                            alignment: Alignment.centerLeft,
                            scale: 1.7,
                            image: AssetImage('images/speech-bubble2.png'),
                            //fit: BoxFit.fill,
                          ),
                        ),
                ),
                SafeArea(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 100,
                        left: 30,
                      ),
                      child: isKeyboardVisible
                          ? null
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'Account',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                    ),
                  ],
                )),
              ],
            )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'email')),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                      obscureText: !_passwordVisible,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        hintText: 'password',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      )),
                  SizedBox(
                    height: 24.0,
                  ),
                  ButtonWidget(
                      label: 'Sign up',
                      color: Color(0xFF006BFF),
                      textColor: Colors.white,
                      onPressed: () async {
                        if (email != null && password != null) {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                            if (newUser != null) {
                              Alert(
                                context: context,
                                type: AlertType.success,
                                title: "Done!",
                                desc: "Registered Successfully",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "OK",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, WelcomeScreen.id);
                                    },
                                    width: 120,
                                  )
                                ],
                              ).show();
                            }
                          } catch (e) {
                            print(e);
                            Alert(
                                    context: context,
                                    //title: "RFLUTTER",
                                    desc:
                                        "Please enter a valid email or password")
                                .show();
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        }
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 0.9,
                        width: 160,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'or',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Container(
                        height: 0.9,
                        width: 160,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ButtonWidget(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    label: 'Log in',
                    color: Colors.white,
                    textColor: Colors.grey,
                    borderColor: Colors.grey,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
