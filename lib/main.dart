import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:herewego/page/home_page.dart';
import 'package:herewego/page/signin_page.dart';
import 'package:herewego/page/signup_page.dart';
import 'package:herewego/page/splash_home.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      routes: {
        SplashPage.id: (context) => SplashPage(),
        SignUpPage.id: (context) => SignUpPage(),
        HomePage.id: (context) => HomePage(),
        SigninPage.id: (context) => SigninPage(),
      },
    );
  }
}

