// import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat/pages/firebasefunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices {
  static Future<String> signupUser(
      String email, String password, String name, BuildContext context) async {
    print("inside signup function");
    try {
      print("try");
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      await FirestoreServices.saveUser(name, email, userCredential.user!.uid);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registration Successful')));
      print("user registered");
      return email;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email Provided already Exists')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return "failed";
  }

  static Future<String> signinUser(
      String email, String password, BuildContext context) async {
    String res = '';
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      res = '$email';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('You are Logged in')));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user Found with this Email')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Password did not match')));
      }
    }
    return res;
  }

  static signoutUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('You are Logged Out')));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
