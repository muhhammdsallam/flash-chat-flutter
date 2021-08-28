import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/button_widget.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'registration_screen.dart';
import 'package:flash_chat/components/curve_shape.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final messageTextController1 = TextEditingController();
  final messageTextController2 = TextEditingController();
  @override
  void dispose() {
    _auth.signOut();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initFirebaseApp();
  }

  void initFirebaseApp() async {
    await Firebase.initializeApp();
  }

  bool _passwordVisible = false;
  bool loginFail = true;
  bool showSpinner = false;
  String email;
  String password;
  final _auth = FirebaseAuth.instance;

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
                                  'Welcome',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'Back',
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
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                          controller: messageTextController1,
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
                          controller: messageTextController2,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          )),
                      SizedBox(
                        height: 24.0,
                      ),
                      ButtonWidget(
                          label: 'Log in',
                          color: Color(0xFF006BFF),
                          textColor: Colors.white,
                          onPressed: () async {
                            messageTextController1.clear();
                            messageTextController2.clear();

                            if (email != null && password != null) {
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                UserCredential userCredential =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                              } catch (e) {
                                print(e);
                                Alert(
                                        context: context,
                                        desc: "Wrong email or password")
                                    .show();
                                email = null;
                                password = null;
                                setState(() {
                                  showSpinner = false;
                                });
                              }

                              final User user = _auth.currentUser;
                              if (user.email == email || !user.isAnonymous) {
                                setState(() {
                                  showSpinner = false;
                                });
                                Navigator.pop(context);
                                Navigator.pushNamed(context, ChatScreen.id);

                                email = null;
                                password = null;
                              }
                            } else {
                              print('null user');
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
                          Navigator.pushNamed(context, RegistrationScreen.id);
                        },
                        label: 'Sign up',
                        color: Colors.white,
                        textColor: Colors.grey,
                        borderColor: Colors.grey,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
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
