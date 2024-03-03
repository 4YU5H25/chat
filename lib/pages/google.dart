import 'package:chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_web/web_only.dart';

Future<void> signinwithgoogle(bool signin, BuildContext context) async {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: clientId,
    signInOption: SignInOption.standard,
    scopes: [
      'email',
    ],
  );

  try {
    GoogleSignInAccount? googleUser = (await googleSignIn.signInSilently(
      reAuthenticate: true,
    ));

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);
    signin = true;
    print(user.user!.displayName);
  } on FirebaseAuthException catch (e) {
    // Handle error, e.g., show a snackbar or dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sign in failed: ${e.message}')),
    );
  }
}

Widget signinbutton() {
  return renderButton(
    configuration: GSIButtonConfiguration(
        text: GSIButtonText.signin,
        type: GSIButtonType.standard,
        shape: GSIButtonShape.pill),
  );
}
