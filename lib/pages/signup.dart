import 'dart:io';

import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/firebase_auth_service.dart';
import 'package:chat/pages/google.dart';
import 'package:chat/pages/home.dart';
import 'package:chat/pages/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'firebase_auth_service.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // final FirebaseAuthService _auth = FirebaseAuthService();
  bool signin = false;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double inputContainerWidth =
        screenHeight > screenWidth ? screenWidth : screenWidth / 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            // gradient: LinearGradient(colors: [
            //   Colors.blue,
            //   Color.fromARGB(255, 24, 55, 255),
            // ]),
            // image: DecorationImage(
            //     image: AssetImage("assets/bg.jpg"), fit: BoxFit.fitWidth),
            ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: inputContainerWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey[200], // Grey fill color
                      border: Border.all(color: Colors.black),
                    ),
                    child: TextFormField(
                        controller: namecontroller,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20.0),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        }),
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: Container(
                    width: inputContainerWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey[200], // Grey fill color
                      border: Border.all(color: Colors.black),
                    ),
                    child: TextFormField(
                      controller: emailcontroller,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: Container(
                    width: inputContainerWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey[200], // Grey fill color
                      border: Border.all(color: Colors.black),
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: Container(
                    width: inputContainerWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey[200], // Grey fill color
                      border: Border.all(color: Colors.black),
                    ),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty ||
                            _passwordController.text != value) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    print("signup pressed");
                    if (_formKey.currentState!.validate()) {
                      if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        // Passwords don't match
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Passwords do not match!'),
                        ));
                        return;
                      }
                      String username = namecontroller.text;
                      String email = emailcontroller.text;
                      String pass = _passwordController.text;
                      await AuthServices.signupUser(
                          email, pass, username, context);
                      Future.delayed(const Duration(seconds: 4));
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Home(email)));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: inputContainerWidth,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await signinwithgoogle(signin, context);
                        if (signin == true) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatPage()));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 18,
                              child: Image.network("assets/google.png",
                                  fit: BoxFit.fitHeight)),
                          (const Text(' Sign Up with Google')),
                        ],
                      ),
                    ),

                    // child: signinbutton(),
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                    width: inputContainerWidth,
                    child: const Divider(
                      thickness: 1,
                      color: Color.fromARGB(255, 70, 70, 70),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    TextButton(
                      onPressed: () {
                        // Add your navigation to login page logic here
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: const Text('Log in'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
