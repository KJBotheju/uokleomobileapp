import 'package:flutter/material.dart';
import 'package:uokleo/screens/adminPage.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _passwordController = TextEditingController();
  final String correctPassword = "123"; // Updated correct password

  void _login() {
    String enteredPassword = _passwordController.text.trim();

    if (enteredPassword == correctPassword) {
      // Successful login, navigate to AdminContect
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminContect()),
      );
    } else {
      // Incorrect password, show error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Login Failed"),
            content: Text(
                "You can't access this page.\nBecause you are not in the admin panel."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/download.jpeg', // Replace with the path to your admin image
                width: 120.0,
                height: 120.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 223, 220, 23)),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
