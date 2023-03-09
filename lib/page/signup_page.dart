import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego/page/signin_page.dart';

import '../service/auth_service.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  static final String id = "signup_page";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var isLoading = false;
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void _doSignUp() {
    String fullname = fullnameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    if (fullname.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      AuthService.signUpUser(fullname, email, password).then((value) =>
      {

        responseSignUp(value!),
      });
    }
  }

  void responseSignUp(User firebaseUser) {
    setState(() {
      isLoading = false;
    });
    Navigator.pushReplacementNamed(context, HomePage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          padding: EdgeInsets.all(20),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  // #fullname
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white54.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextField(
                      controller: fullnameController,
                      decoration: InputDecoration(
                        hintText: "Full Name",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  // #email
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white54.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  // #password
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white54.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  // #signin buttom
                  GestureDetector(
                    onTap: () {
                      _doSignUp();
                    },
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                          child: Text("Sign Up", style: TextStyle(
                              color: Colors.black, fontSize: 17),)
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Already have an account",
                        style: TextStyle(color: Colors.black, fontSize: 16),),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, SigninPage.id);
                        },
                        child: Text("Sign In", style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),

                  SizedBox(height: 20,)
                ],
              ),

              isLoading ? Center(
                child: CircularProgressIndicator(),
              ) : SizedBox.shrink()
            ],
          )
      ),
    );
  }
}
