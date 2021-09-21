import 'package:MyFoodLogin/theme/approutes.dart';
import 'package:MyFoodLogin/view/MainPage.dart';
import 'package:firebase_core/firebase_core.dart';

import './view/Login.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/git 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyFood());
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
