import 'package:flutter/material.dart';
import 'package:mdefi/services/auth.dart';
import 'package:mdefi/shared/loading.dart';
import 'package:mdefi/screens/home/homeApp.dart';
import 'package:nice_button/nice_button.dart';



class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email='';
  String password='';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(

      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        elevation: 0.0,
        title: Text('Register to M-Défi'),
          actions: <Widget>[
      FlatButton.icon(
      icon: Icon(Icons.person),
      label: Text('Sign In'),
      onPressed: () {
        widget.toggleView();
      })
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0)
                    ),
                      focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0)
                )
                  ),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val){
                    setState (()=> email = val);

                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Password',
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2.0)
                      )
                  ),
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                  onChanged: (val){
                    setState (()=> password = val);
                  },
                ),
                SizedBox(height: 20.0),
                NiceButton(
                  // width: 515,
                  elevation: 5.0,
                  radius: 40.0,
                  text: "Register",
                  background: Colors.blue,
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {

                      setState(() {
                        loading = true;
                      });

                      dynamic result = await _auth.registerWithEmailAndpassword(
                          email, password);



                      if (result == null) {

                        setState(() {
                          loading = false;
                          error = 'please supply a valid email';
                        });

                      }
                    }
                  },
                ),

                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          )
      ),
    );
  }
}
