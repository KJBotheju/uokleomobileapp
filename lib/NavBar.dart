// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:uokleo/screens/SignIn.dart';
import './screens/EventPage.dart';
import './screens/BlogPage.dart';
import './screens/Projects.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    BlogPage(),
    ProjectPage(),
    EventPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 3) {
            // Logout action
            // Here, you can add your logout logic, such as signing out from Firebase or clearing user data
            // Then, navigate to the login page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignInPage()),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        backgroundColor: Color.fromARGB(255, 248, 224, 3),
        selectedItemColor: Color.fromARGB(255, 10, 0, 0),
        unselectedItemColor: Color.fromARGB(255, 11, 0, 0),
        items: [
          BottomNavigationBarItem(
            icon: buildIconWithBox(Icons.article, 0),
            label: 'Blogs',
          ),
          BottomNavigationBarItem(
            icon: buildIconWithBox(Icons.work, 1),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: buildIconWithBox(Icons.calendar_today, 2),
            label: 'Upcoming',
          ),
          BottomNavigationBarItem(
            icon: buildIconWithBox(Icons.logout, 3),
            label: 'Logout',
          ),
        ],
      ),
    );
  }

  Widget buildIconWithBox(IconData icon, int index) {
    return Container(
      width: 60,
      height: 40,
      decoration: BoxDecoration(
        color: _currentIndex == index
            ? Color.fromARGB(255, 251, 249, 249)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Icon(
          icon,
          size: 28,
          color: _currentIndex == index
              ? Color.fromARGB(255, 4, 0, 0)
              : const Color.fromARGB(255, 10, 0, 0),
        ),
      ),
    );
  }
}
