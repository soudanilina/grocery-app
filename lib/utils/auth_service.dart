import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery/auth/sign_in.dart';
import 'package:grocery/models/user.dart';
import 'package:grocery/screens/home/home_page.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final gooleSignIn = GoogleSignIn();

  // a simple sialog to be visible everytime some error occurs
  showErrDialog(BuildContext context, String err) {
    // to hide the keyboard, if it is still p
    FocusScope.of(context).requestFocus(new FocusNode());
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: Text(
                  "Error",
                  style: TextStyle(color: Colors.red),
                ),
                content: Text(err),
                actions: <Widget>[
                  OutlineButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"),
                  ),
                ]));
  }

  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapShot.hasData) {
          return HomePage();
        } else if (snapShot.hasError) {
          return Center(
            child: Text('something went wrong'),
          );
        } else {
          return SignIn();
        }
      },
    );
  }

  Future<User?> gogleSignUp(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await gooleSignIn.signIn();
    try {
      if (googleUser != null) {
        final GoogleSignInAuthentication? googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        final User? user = (await _auth.signInWithCredential(credential)).user;
        postDetailsToFirestore(user!.displayName, user.photoURL);
        // print("signed in " + user.displayName);

        return user;
      }
    } catch (e) {}
  }

  // returning user to directly access UserID
  Future<User?> signin(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      print(user);
      return Future.value(user);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "invalid-email":
          showErrDialog(context, "Your email address appears to be malformed.");
          break;
        case "wrong-password":
          showErrDialog(context, "Your password is wrong.");
          break;
        case "user-not-found":
          showErrDialog(context, "User with this email doesn't exist.");
          break;
        case "user-disabled":
          showErrDialog(context, "User with this email has been disabled.");
          break;
        case "too-many-requests":
          showErrDialog(context, "Too many requests");
          break;
        case "operation-not-allowed":
          showErrDialog(
              context, "Signing in with Email and Password is not enabled.");
          break;
        default:
          showErrDialog(context, "An undefined Error happened.");
      }
      // since we are not actually continuing after displaying errors
      // the false value will not be returned
      // hence we don't have to check the valur returned in from the signin function
      // whenever we call it anywhere
      //return Future.value(null);
    }
  }

  Future<User?> signUp(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return Future.value(user);
      // return Future.value(true);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'email-already-in-use':
          showErrDialog(context, "Email Already Exists");
          break;
        case 'invalid-email':
          showErrDialog(context, "Invalid Email Address");
          break;
        case 'weak-password':
          showErrDialog(context, "Please Choose a stronger password");
          break;
        case "operation-not-allowed":
          showErrDialog(
              context, "Signing in with Email and Password is not enabled.");
          break;
        default:
          showErrDialog(context, "An undefined Error happened.");
      }
      // return Future.value(null);
    }
  }

  postDetailsToFirestore(String? username, String? image) async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = username;
    userModel.image = image;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
  }

  Future<bool> signOutUser() async {
    User? user = await _auth.currentUser;
    print(user);
    //print(user!.providerData);
    //var proider = user!.providerData[0].providerId;

    if (user!.providerData[0].providerId == 'password') {
      await _auth.signOut();
    } else if (user.providerData[0].providerId == 'google.com') {
      // print(user.providerData[0].providerId);
      await _auth.signOut();
      // if we want to show the email dialog everytime
      await gooleSignIn.disconnect();
    }

    return Future.value(true);
  }
}
