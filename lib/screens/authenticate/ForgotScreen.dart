/*
 * Author : Loris Clivaz
 * Date creation : 04 juin 2020
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/screens/home/homeApp.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:mdefi/services/database.dart';

/*
 * Classe qui va gérer le mot de passe si l'utilisateur l'oublie
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class ForgotScreen extends StatefulWidget {

  @override
  _ForgotScreenState createState() {
    return _ForgotScreenState();
  }
}

class _ForgotScreenState extends State<ForgotScreen> {

  //Variable de la base de données
  final Database database = Database();

  //Variable de récupération de la saisie de l'utilisateur
  final myController = TextEditingController();

  //Méthode permettant de supprimer le state
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Dispose forgot screen");
  }

  //Design de la page
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/BackGroundImage.jpg"),fit: BoxFit.cover)),
    child: Scaffold(
    backgroundColor: Colors.transparent,
    appBar: AppBar(
    leading: BackButton(
    color: Colors.black,
    onPressed:() => Navigator.of(context).pop() ,
    ),
    title: Text("Mot de passe"),
    backgroundColor: Colors.blueGrey[400],
    elevation: 0.0,
    ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              Text("Nous allons vous envoyer un lien, Veuillez cliquer dessus afin de réinitialiser votre mot de passe",
              style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Text(''),
              Text(''),
              Theme(
                data: ThemeData(
                  hintColor: Colors.blueGrey
                ),
                  child: TextFormField(
                    controller: myController,
                      validator: (val) => val.toString() != HomeApp.email ? 'Entrer un mail valide' : null,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: 'Email',
                      fillColor: Colors.white30,
                      filled: true,
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.black,width: 1)
                    )
                  ),
                ),
              ),
              Text(''),
              Text(''),
              NiceButton(
                // width: 515,
                elevation: 8.0,
                radius: 52.0,
                text: "Envoyer",
                background: Colors.blue,
                onPressed: () async {
                  if(myController.text == HomeApp.email)
                    {
                      FirebaseAuth.instance.sendPasswordResetEmail(email: myController.text).then((value)=> print("Veuillez vérifier vos emails"));
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeApp(),
                      ));
                      dispose();
                    }else{
                    print('not valid mail');
                  }
                  },
              ),
            ],
          ),
        ),
      ),
    ),
    ),
    );
  }
}

