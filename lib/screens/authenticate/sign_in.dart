import 'package:flutter/material.dart';
import 'package:mdefi/screens/authenticate/ForgotScreen.dart';
import 'package:mdefi/services/auth.dart';
import 'package:mdefi/shared/loading.dart';
import 'package:nice_button/nice_button.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Text field state

  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(

      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        elevation: 0.0,
        title: Text('Connexion'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Enregistrement'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Image.asset('assets/logo.jpg',height: 200,width: 200,),

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
                  validator: (val) => val.isEmpty ? 'Entrer un email' : null,
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
                  validator: (val) => val.length < 6 ? 'Enter un mot de passe d''au moins 6 charactères' : null,
                  onChanged: (val){
                    setState (()=> password = val);
                  },
                ),
                SizedBox(height: 20.0),


                NiceButton(
                  // width: 515,
                  elevation: 8.0,
                  radius: 52.0,
                  text: "Connexion",
                  background: Colors.blue,
                  onPressed: () async {

                    if(_formKey.currentState.validate()) {

                      setState (() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndpassword(email, password);
                      print(email + password);
                      if (result == null) {

                        setState(() {
                          loading = false;
                          error = 'Email ou mot de passe incorrect';
                        });

                      }
                    }                  },
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
                SizedBox(
                  child: InkWell(
                    onTap: ()=> Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ForgotScreen(),
                    )),
                    child: Text('Mot de passe oublié'),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
