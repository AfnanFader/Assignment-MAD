import 'package:assignment_project/model/localSetting.dart';
import 'package:assignment_project/model/user.dart';
import 'package:assignment_project/pages/Homepage.dart';
import 'package:assignment_project/pages/LoginPage.dart';
import 'package:assignment_project/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Wrapper()
    );
  }
}

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  //Initialize firebase connection <-- new method (June > Aug 2020)
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, init) {
        //Error handle ... optional : add offline mode listening to wifi/LTE connection status. use cached data
        if (init.hasError) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        //Initialization done. TODO : IMPLEMENT GLOBAL STATE MANAGEMENT
        if (init.connectionState == ConnectionState.done) {
          return StreamBuilder<UserID>(
            stream: AuthService().loginStream,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return HomePage();
              } else {
                return LoginPage();
              }
            },
          );
        } else {
          //Initialization status [waiting, failing, starting]
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
