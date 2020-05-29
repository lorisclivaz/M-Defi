import 'package:flutter/material.dart';


class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      body: Center(
        child: Padding(padding: EdgeInsets.only(top: 50, left: 20, right: 20),

          child: Column(
            children: <Widget>[

              Text("We will mail you a link ... Please click on that link to reset your password",
              style: TextStyle(color: Colors.black, fontSize: 20),
              ),

            ],
          ),


        ),

      ),

    );
  }
}

