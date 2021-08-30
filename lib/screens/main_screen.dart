import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'settings_screen.dart';
import 'drawer_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

User loggedInUser;

class MainScreen extends StatefulWidget {
  static const String id = 'Main';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    initFirebaseApp();
  }

  void initFirebaseApp() async {
    await Firebase.initializeApp();
  }

  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Users',
    ),
    ChatScreen(),
    DrawerScreen()
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.supervised_user_circle,
              //color: Color(0xFF006BFF),
              size: 30,
            ),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble,
              //color: Color(0xFF006BFF),
              size: 30,
            ),
            label: 'GroupChat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              //color: Color(0xFF006BFF),
              size: 30,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF006BFF),
        onTap: _onItemTapped,
      ),
    );
  }
}
