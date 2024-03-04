import 'dart:convert';

import 'package:chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<dynamic> signinwithgoogle(BuildContext context) async {
  print("signin called");
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: clientId,
    signInOption: SignInOption.standard,
    scopes: [
      'email',
    ],
  );

  try {
    print("inside try of gsignin");
    GoogleSignInAccount? googleUser = (await googleSignIn.signIn());

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(user.additionalUserInfo!.profile.toString());

    print(user.user!.displayName);
    return (user.additionalUserInfo!.profile);
  } on FirebaseAuthException catch (e) {
    // Handle error, e.g., show a snackbar or dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sign in failed: ${e.message}')),
    );
  }
}
