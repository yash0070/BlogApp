import 'package:blog_app/LogIn/log_in.dart';
import 'package:blog_app/SignUp/signUp_screen.dart';
import 'package:blog_app/Views/Home/home_screen.dart';
import 'package:blog_app/Views/add_blog.dart';
import 'package:blog_app/Welcome/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
