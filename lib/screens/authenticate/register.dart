/*
 * Author : Loris Clivaz
 * Date creation : 04 juin 2020
 */

import 'package:flutter/material.dart';
import 'package:mdefi/services/auth.dart';
import 'package:mdefi/shared/loading.dart';
import 'package:nice_button/nice_button.dart';

/*
 * Classe qui va gérer l'enregistrement de l'utilisateur
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */
class Register extends StatefulWidget {

  //On récupère la fonction toggleView
  final Function toggleView;

  //Constructeur du stateFul
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  //Variable d'authentification
  final AuthService _auth = AuthService();

  //Variable de controle de saisie
  final _formKey = GlobalKey<FormState>();
  String email='';
  String password='';
  String error = '';

  //Variable de la page du loading
  bool loading = false;

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
          title: Text('Enregistrement'),
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Connexion'),
                onPressed: () {
                  widget.toggleView();
                })
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
                    validator: (val) => val.isEmpty ? 'Enter un mail' : null,
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
                    elevation: 5.0,
                    radius: 40.0,
                    text: "Enregistrer",
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
                            error = 'Enter un mail valide';
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
      )),
    );
  }
}
