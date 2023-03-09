

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herewego/page/signin_page.dart';

import '../service/auth_service.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  static final String id = "splash_page";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    _initTimer();
  }

  void _initTimer(){
    Timer(const Duration(seconds: 2),(){
      _callNextPage();
    });
  }
  _callNextPage(){
    if(AuthService.isLoggedIn()){
      Navigator.pushReplacementNamed(context, HomePage.id);
    }else{
      Navigator.pushReplacement(
        context,MaterialPageRoute(builder: (context) => SigninPage()),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.orange,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Text("Herwego", style: TextStyle(color: Colors.white, fontSize: 35),),
              ),
            ),

            Text("All rights reserved", style: TextStyle(color: Colors.white, fontSize: 16),),

            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
