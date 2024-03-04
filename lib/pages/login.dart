import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/google.dart';
import 'package:chat/pages/home.dart';
// import 'package:chat/pages/firebase_auth_service.dart';
import 'package:flutter/material.dart';

import 'firebase_auth_service.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
          'Login',
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
        decoration: const BoxDecoration(),
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
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String email = emailcontroller.text;
                      String password = _passwordController.text;
                      String res = await AuthServices.signinUser(
                          email, password, context);
                      if (res != '') {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Home(res)));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: inputContainerWidth,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        signinwithgoogle(signin, context);
                        if (signin == true) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatPage()));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 255, 255)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 18,
                              child: Image.network("assets/google.png",
                                  fit: BoxFit.fitHeight)),
                          (const Text(' Login with Google')),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                    width: inputContainerWidth,
                    child: const Divider(
                      thickness: 1,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
