/*
 * Author : Loris Clivaz
 * Date creation : 04 juin 2020
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mdefi/screens/authenticate/ForgotScreen.dart';
import 'package:mdefi/screens/authenticate/register.dart';
import 'package:mdefi/screens/home/homeApp.dart';
import 'package:mdefi/services/auth.dart';
import 'package:mdefi/shared/loading.dart';
import 'package:nice_button/nice_button.dart';

/*
 * Classe qui va gérer l'authentification de l'utilisateur
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */
class SignIn extends StatefulWidget {

  //On récupère la fonction toggleView
  final Function toggleView;

  //Constructeur
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  //Variable d'authentification
  final AuthService _auth = AuthService();

  //Variable de controle de saisie
  final _formKey = GlobalKey<FormState>();
  String email='';
  String password='';
  String error='';

  //Variable de la page du loading
  bool loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Dispose signin");
  }

  //Design de la page
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/BackGroundImage.jpg"),fit: BoxFit.cover)),
      child: Scaffold(
    backgroundColor: Colors.transparent,
    appBar: AppBar(
    backgroundColor: Colors.blueGrey[400],
    elevation: 0.0,
    title: Text('Connexion'),
    actions: <Widget>[
    FlatButton.icon(
    icon: Icon(Icons.person),
    label: Text('Enregistrement'),
    onPressed: () {
    //widget.toggleView();
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              Register(),
        ));

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
              SizedBox(
                child: Container(
                  width: 160.0,
                  height: 160.0,
                  decoration: new BoxDecoration(
                    image:DecorationImage(
                       image:
                        AssetImage('assets/logo.jpg')
                    )
                      ,
                    borderRadius: new BorderRadius.circular(36.0),
                  ),
                ),
              ),
              Text(''),
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
              setState(() {
                loading = true;
              });
            if(_formKey.currentState.validate()) {

            dynamic result = await _auth.signInWithEmailAndpassword(email, password);

            if(result != null)
              {

                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          HomeApp(),
                    ));
              }

            if (result == null) {

            setState(() {
            loading = false;
            error = 'Email ou mot de passe incorrect';
            });
            }
            }
            },
            ),
            SizedBox(height: 12.0),
            Text(
            error,
            style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
            Text(''),
              NiceButton(
                // width: 515,
                elevation: 8.0,
                radius: 52.0,
                text: "Mot de passe oublié",
                background: Colors.white30,
                fontSize: 19,
                onPressed: ()  {

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ForgotScreen(),
                  ));
                  },
              )
            ],
            ),
            )
            ),
            ),
        ),
    );
  }
}
