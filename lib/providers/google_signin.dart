import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery/models/user.dart';

class GoggleSignIn extends ChangeNotifier {
  // final googleSignIn = GoogleSignIn(
  //   scopes: ['email'],
  // );
  // GoogleSignInAccount? _User;
  // GoogleSignInAccount get user => _User!;
  // Future googleSignUp() async {
  //   try {
  //     final FirebaseAuth _auth = FirebaseAuth.instance;

  //     final googleUser = await googleSignIn.signIn();

  //     if (googleUser == null) return;
  //     _User = googleUser;
  //     final googleAuth = await googleUser.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     await _auth.signInWithCredential(credential);
  //     // print("signed in " + user.displayName);

  //     notifyListeners();
  //   } catch (e) {}
  // }

  // Future googleSignOut() async {
  //   await googleSignIn.disconnect();
  //   FirebaseAuth.instance.signOut();
  // }
  UserModel loggedInUser = UserModel();
  void getUserData() async {
    UserModel userModel;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
    }).onError((error, stackTrace) {
      print(error);
    });
    notifyListeners();
  }

  UserModel get currentUserData {
    return loggedInUser;
  }
}
