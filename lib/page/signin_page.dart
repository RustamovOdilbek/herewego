import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego/page/signup_page.dart';

import '../service/auth_service.dart';
import 'home_page.dart';

class SigninPage extends StatefulWidget {
  static final String id = "signin_page";

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  var isLoading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void _doSignIn(){
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    if(email.isEmpty || password.isEmpty) return;

    setState(() {
      isLoading = true;
    });
    AuthService.signInUser(email, password).then((value) => {
      responseSignIn(value!),
    });
  }

  void responseSignIn(User firebaseUser)async{
    // You can store user id locally
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
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

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
                    onTap: (){
                      _doSignIn();
                    },
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                          child: Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 17),)
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Don't have account?", style: TextStyle(color: Colors.black, fontSize: 16),),
                      SizedBox(width: 10,),
                      GestureDetector(
                        child: Text("Sign Up", style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                        onTap: (){
                          Navigator.pushReplacementNamed(context, SignUpPage.id);
                        },
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
