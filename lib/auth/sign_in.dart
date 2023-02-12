import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery/config/colors.dart';
import 'package:grocery/providers/form_validation.dart';
import 'package:grocery/screens/home/home_page.dart';
import 'package:grocery/utils/auth_service.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String? email;
  String? password;
  String? username;
  String? confrimPassword;
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
  void Login() {
    AuthService().signin(email!, password!, context).then((value) {
      if (value != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      }
    });
  }

  void register() {
    print('works');
    AuthService().signUp(email!, password!, context).then((value) {
      AuthService().postDetailsToFirestore(username!,
          'https://images.pexels.com/photos/1382734/pexels-photo-1382734.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1');
      if (value != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      }
    });
  }

  bool isSignedScreen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.backgroundColor,
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/login.png"),
                        fit: BoxFit.cover)),
              ),
              // main container for logging and signin
              AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.bounceInOut,
                  padding: EdgeInsets.all(20),
                  height: !isSignedScreen ? 390 : 380,
                  width: MediaQuery.of(context).size.width - 40,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 40,
                            spreadRadius: 0)
                      ]),
                  child: SingleChildScrollView(
                      child: Column(children: [
                    // login/signup toggle buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignedScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'Sign in',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: !isSignedScreen
                                      ? Palette.textColor1
                                      : Palette.textgreyColor,
                                ),
                              ),
                              if (!isSignedScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: primaryColor,
                                ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignedScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'Sign up',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: isSignedScreen
                                      ? Palette.textColor1
                                      : Palette.textgreyColor,
                                ),
                              ),
                              if (isSignedScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: primaryColor,
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                    // login/signup toggle forms
                    if (!isSignedScreen)
                      //  buildLoginSection(),
                      buildLoginSection(),
                    if (isSignedScreen) buildRegisterSection()
                  ]))),
              SizedBox(
                height: 20,
              ),
              if (!isSignedScreen)
                // login Button
                Column(
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            side: BorderSide(width: 1, color: Colors.grey),
                            minimumSize: Size(175, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            primary: Colors.white,
                            backgroundColor: primaryColor),
                        onPressed: () async {
                          if (formKeys[0].currentState!.validate()) {
                            Login();
                          }
                        },
                        child: Text("Login")),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont have an account?',
                          style:
                              TextStyle(color: Color(0xFF959595), fontSize: 16),
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                isSignedScreen = true;
                              });
                            },
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ))
                      ],
                    ),
                    // SizedBox(height: 30,),
                  ],
                ),
              if (isSignedScreen)
                Column(
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            side: BorderSide(width: 1, color: Colors.grey),
                            minimumSize: Size(175, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            primary: Colors.white,
                            backgroundColor: primaryColor),
                        onPressed: () async {
                          if (formKeys[1].currentState!.validate()) {
                            register();
                          }
                        },
                        child: Text("Register")),
                  ],
                )
            ])));
  }

  // loging form ui
  Container buildLoginSection() {
    final validationService = Provider.of<FormValidation>(context);

    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(children: [
          Container(
            child: Form(
              key: formKeys[0],
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: TextFormField(
                    decoration: kinput.copyWith(
                      prefixIcon: Icon(
                        FeatherIcons.mail,
                        color: Palette.iconColor,
                      ),
                      hintText: 'email',
                    ),
                    validator: (val) {
                      validationService.changeEmail(val!);
                      return validationService.email;
                      // return changeEmail(val!);
                    },
                    onChanged: (val) {
                      email = val;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: kinput.copyWith(
                        prefixIcon: Icon(
                          FeatherIcons.lock,
                          color: Palette.iconColor,
                        ),
                        hintText: 'Password',
                        suffixIcon: Icon(
                          FeatherIcons.eye,
                          color: Palette.iconColor,
                          size: 17,
                        )),
                    validator: (val) {
                      validationService.changePassword(val!);
                      return validationService.password;
                    },
                    onChanged: (val) {
                      password = val;
                      ;
                    },
                  ),
                )
              ]),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Text(
              'forget password',
              style:
                  TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 30),
            color: Colors.white,
            width: double.infinity,
            height: 20,
            child: Row(
              children: [
                buildDivider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      color: Palette.iconColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                buildDivider(),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                socialIcon(() {}, FeatherIcons.facebook),
                SizedBox(
                  width: 25,
                ),
                socialIcon(() async {
                  // final provider =  Provider.of<GoggleSignIn>(context, listen: false);
                  // provider.googleSignUp();
                  await AuthService()
                      .gogleSignUp(context)
                      .whenComplete(() async {
                    User? user = await FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  });
                }, Icons.email_outlined),
                SizedBox(
                  width: 25,
                ),
                socialIcon(() {}, FeatherIcons.twitter),
              ],
            ),
          ),
        ]));
  }

// register section
  Container buildRegisterSection() {
    final validationService = Provider.of<FormValidation>(context);
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Form(
              key: formKeys[1],
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: TextFormField(
                      decoration: kinput.copyWith(
                        prefixIcon: Icon(
                          FeatherIcons.mail,
                          color: Palette.iconColor,
                        ),
                        hintText: 'Username',
                      ),
                      validator: (val) {
                        validationService.changeName(val!);
                        return validationService.name;
                      },
                      onChanged: (val) {
                        username = val;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: TextFormField(
                      decoration: kinput.copyWith(
                        prefixIcon: Icon(
                          FeatherIcons.mail,
                          color: Palette.iconColor,
                        ),
                        hintText: 'email',
                      ),
                      validator: (val) {
                        validationService.changeEmail(val!);
                        return validationService.email;
                      },
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: kinput.copyWith(
                          prefixIcon: Icon(
                            FeatherIcons.lock,
                            color: Palette.iconColor,
                          ),
                          hintText: 'Password',
                          suffixIcon: Icon(
                            FeatherIcons.eye,
                            color: Palette.iconColor,
                            size: 17,
                          )),
                      validator: (val) {
                        validationService.changePassword(val!);
                        return validationService.password;
                      },
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: kinput.copyWith(
                          prefixIcon: Icon(
                            FeatherIcons.lock,
                            color: Palette.iconColor,
                          ),
                          hintText: 'Confirm password',
                          suffixIcon: Icon(
                            FeatherIcons.eye,
                            color: Palette.iconColor,
                            size: 17,
                          )),
                      validator: (val) {
                        validationService.changeConfirmPassword(val!, password);
                        return validationService.confrimPassword;
                      },
                      onChanged: (val) {
                        confrimPassword = val;
                      },
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

// divider
  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: Palette.iconColor,
        height: 1.5,
      ),
    );
  }

  GestureDetector socialIcon(Function()? onTap, IconData icon) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Icon(
          icon,
          color: Color.fromARGB(255, 155, 155, 155),
          size: 20,
        ),
      ),
    );
  }
}
