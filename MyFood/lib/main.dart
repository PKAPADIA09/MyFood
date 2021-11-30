import 'package:myfood/theme/approutes.dart';
import 'package:firebase_core/firebase_core.dart';
import './view/Login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './view/MainPage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;
  print(auth.currentUser != null);
  auth.currentUser != null ? runApp(LoggedInMyFood()) : runApp(MyFood());
}

class MyFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      routes: Routes.define(),
    );
  }
}

class LoggedInMyFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      routes: Routes.define(),
    );
  }
}

