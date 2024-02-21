// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uokleo/HomePage.dart';
import 'package:uokleo/resuable_widgets/reusable_widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController =
      TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.09, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/download.jpeg"),
                Text(
                  "LEO CLUB OF UNIVERSITY OF KELANIYA",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("UserName", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Email", Icons.person_outline, false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("New Password", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Confirm Password", Icons.lock_outline, true,
                    _confirmPasswordTextController),
                const SizedBox(
                  height: 20,
                ),
                SignInSignUpButton(context, false, () async {
                  // Validate the form fields
                  if (_userNameTextController.text.isEmpty ||
                      _emailTextController.text.isEmpty ||
                      _passwordTextController.text.isEmpty ||
                      _confirmPasswordTextController.text.isEmpty) {
                    // Show an error message if any field is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill in all fields.'),
                      ),
                    );
                    return;
                  }

                  // Check if the passwords match
                  if (_passwordTextController.text !=
                      _confirmPasswordTextController.text) {
                    // Show an error message if passwords don't match
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Passwords do not match.'),
                      ),
                    );
                    return;
                  }

                  try {
                    // Create a new user with email and password
                    await _auth.createUserWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text,
                    );

                    // If successful, navigate to the homepage
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  } catch (e) {
                    // Show an error message if authentication fails
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: $e'),
                      ),
                    );
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
