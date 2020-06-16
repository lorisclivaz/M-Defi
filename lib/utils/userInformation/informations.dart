/*
 * Author : Loris Clivaz
 * Date creation : 08 juin 2020
 */

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/userInfoSupp.dart';
import 'package:mdefi/screens/authenticate/ForgotScreen.dart';
import 'package:mdefi/screens/home/homeApp.dart';
import 'package:mdefi/services/auth.dart';
import 'package:mdefi/services/database.dart';
import 'package:nice_button/NiceButton.dart';

/*
 * Classe qui va gérer le profil de l'utilisateur
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {

  //Variable current user
  final AuthService _auth = AuthService();

  //Variable de la base de données
  final fb = FirebaseDatabase.instance.reference().child("users");

  //Variable utilisateur
  Database updateUser = Database();
  String currentUid;
  UserInfoSupp user = new UserInfoSupp('','', '', '', '', '',
      '', '');
  UserInfoSupp dataFields = new UserInfoSupp('','', '', '', '', '',
      '', '');
  List<UserInfoSupp> list = List();

  //Variable de controle des saisies
  TextEditingController nom = new TextEditingController();
  TextEditingController prenom = new TextEditingController();
  TextEditingController ecole = new TextEditingController();
  TextEditingController filiere = new TextEditingController();
  TextEditingController annee = new TextEditingController();


  //Méthode de chargement des données
  @override
  void initState (){
    super.initState();


    //Méthode de chargement de l'uid de l'utilisateur
    _auth.getCurrentUID().then((String value){
      currentUid = value;
    });

    //Méthode de chargement de l'utilisateur dans la base de données
    fb.once().then((DataSnapshot snap){
      var data = snap.value;
      list.clear();
      data.forEach((key,value){
        user = new UserInfoSupp(key,value['Uid'], value['Email'], value['Annee'], value['Ecole'], value['Filiere'], value['Nom'], value['Prenom']);
        list.add(user);
      });

      //Ajout d'informations dans la list avec condition
      dataFields = list.singleWhere((tempSB) => tempSB.uid==currentUid);
      setState(() {
      });
    });
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
                title: Text("Mes informations"),
                backgroundColor: Colors.blueGrey[400],
                elevation: 0.0,

              ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                Image.asset('assets/user.png',height: 150,width: 150,),
                SizedBox(height: 20.0),
                TextFormField(
                autofocus: true,
                  controller: nom,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: 'Nom : '+dataFields.nom,
                      hintText: dataFields.nom,
                      fillColor: Colors.white30,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2.0)
                      )
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: prenom,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: 'Prénom : '+dataFields.prenom,
                      hintText: dataFields.prenom,
                      fillColor: Colors.white30,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2.0)
                      )
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: 'Email : '+dataFields.email,
                      hintText: dataFields.email,
                      fillColor: Colors.white30,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2.0)
                      )
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: ecole,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: 'Ecole : '+dataFields.ecole,
                      hintText: dataFields.ecole,
                      fillColor: Colors.white30,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2.0)
                      )
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: filiere,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: 'Filière : '+dataFields.filiere,
                      hintText: dataFields.filiere,
                      fillColor: Colors.white30,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2.0)
                      )
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: annee,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: 'Année : '+dataFields.annee,
                      hintText: dataFields.annee,
                      fillColor: Colors.white30,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2.0)
                      )
                  ),
                ),
                SizedBox(height: 12.0),
                SizedBox(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child:NiceButton(
                      // width: 515,
                      elevation: 5.0,
                      radius: 40.0,
                      text: "mot de passe",
                      background: Colors.white30,
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotScreen(),
                        ));
                        },
                    ) ,
                  ),
                ),
                SizedBox(height: 12.0),
                NiceButton(
                  // width: 515,
                  elevation: 5.0,
                  radius: 40.0,
                  text: "Modifier",
                  background: Colors.white30,
                  onPressed: () async {
                    //Condition si la valeur est null
                    if(nom.text == "")
                      {
                        nom.text=dataFields.nom;
                      }
                    if(prenom.text == "")
                    {
                      prenom.text = dataFields.prenom;
                    }
                    if(ecole.text == "")
                      {
                        ecole.text = dataFields.ecole;
                      }
                    if(filiere.text == "")
                      {
                        filiere.text = dataFields.filiere;
                      }
                    if(annee.text == ""){
                      annee.text = dataFields.annee;
                    }
                    updateUser.updateUser(dataFields.key, nom.text, prenom.text, ecole.text, filiere.text, annee.text);

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomeApp(),
                    ));

                    },
                )
              ],
            ),
          )
      ),
    )
    )
    );
  }
  }

