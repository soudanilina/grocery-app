import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery/config/colors.dart';
import 'package:grocery/providers/form_validation.dart';
import 'package:grocery/providers/google_signin.dart';
import 'package:grocery/utils/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //   options: FirebaseOptions(
      //   apiKey: "XXX",
      //   appId: "XXX",
      //   messagingSenderId: "XXX",
      //   projectId: "XXX",
      // ),
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<GoggleSignIn>(
            create: (context) => GoggleSignIn(),
          ),
          ChangeNotifierProvider<FormValidation>(
            create: (context) => FormValidation(),
          ),
        ],
        child: MaterialApp(
            theme: ThemeData(
              //      primarySwatch: Colors.blue,
              appBarTheme: AppBarTheme(
                color: Colors.white,
              ),
              primaryColor: primaryColor,
              scaffoldBackgroundColor: Colors.white,
            ),
            debugShowCheckedModeBanner: false,
            home: SplashScreen()));
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 4500),
      vsync: this,
      value: 0.05,
      lowerBound: 0.1,
      upperBound: 0.7,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    _controller.forward();

    Future.delayed(Duration(seconds: 2), () async {
      _controller.stop();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AuthService().handleAuthState(),
      ));
      //_fetchSessionAndNavigate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return new MaterialApp(
        theme: new ThemeData(scaffoldBackgroundColor: Colors.blueGrey),
        debugShowCheckedModeBanner: false,
        home: Stack(children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/bg-splash.jpg"),
                        fit: BoxFit.fill)),
                child: Container(
                    color: Color(0xFF159D3B).withOpacity(0.6),
                    child: Stack(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Positioned(
                              bottom: MediaQuery.of(context).size.height - 550,
                              right: 0,
                              left: 0,
                              // top: 20,
                              child: Container(
                                // color: Colors.amber,
                                child: ScaleTransition(
                                  scale: _animation,
                                  alignment: Alignment.center,
                                  child: Center(
                                    child: Container(
                                      // width: MediaQuery.of(context).size.width * 0.8,
                                      // height: MediaQuery.of(context).size.height * 0.85,
                                      // width: double.infinity,
                                      // height: 500,
                                      alignment: Alignment(0, 0),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 20),
                                      child: Image.asset(
                                        "assets/splash-popup.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  //  ),
                                ),
                              ),
                            )
                            // Column(children: <Widget>[
                            //  // Expanded(
                            //    // child:

                            // ]),
                          ],
                        ),
                        isLoading
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    CircularProgressIndicator(),
                                  ],
                                ),
                              )
                            : Container()
                      ],
                    )),
              ))
        ]));
  }
}
