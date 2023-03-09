import 'package:flutter/material.dart';

import '../service/auth_service.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: Container(
        child: Center(
          child: TextButton(
            onPressed: () {
              AuthService.signOutUser(context);
            },
            child: Text("Log Out", style: TextStyle(color: Colors.red),),
          ),
        ),
      ),
    );
  }
}
