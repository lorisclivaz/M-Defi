/*
 * Author : Loris Clivaz
 * Date creation : 07 juin 2020
 */

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:mdefi/models/userInfoSupp.dart';
import 'package:mdefi/screens/Profil/Profil.dart';
import 'package:mdefi/screens/Themes/langueList.dart';
import 'package:mdefi/screens/Themes/themesList.dart';
import 'package:mdefi/screens/authenticate/sign_in.dart';
import 'package:mdefi/screens/classement/classement.dart';
import 'package:mdefi/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/services/database.dart';
import 'package:mdefi/utils/about/about.dart';
import 'package:mdefi/utils/mainDrawer.dart';
import 'package:nice_button/NiceButton.dart';

/*
 * Classe qui va gérer la navigation entre les différentes fonctions de l'application
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */
class HomeApp extends StatelessWidget {

  //Variables d'authentification
  final AuthService _auth = AuthService();

  //Variable de la base de données
  final DBRef = FirebaseDatabase.instance.reference();
  Database database = new Database();

  //Variable de l'utilisateur
  static String email ;
  static String uid ;
  static UserInfoSupp user;

  //Design de la page
  @override
  Widget build(BuildContext context) {

    //Chargement du mail de l'utilisateur
    _auth.getCurrentEmail().then((String result){
      email = result;
    });

    //Chargement de l'uid de l'utilisateur
    _auth.getCurrentUID().then((String value){
      uid = value;
    });

    //Chargement de toute les informations personnelles de l'utilisateur
    DBRef.child('users').orderByChild('Uid').equalTo(uid).onChildAdded.listen((data){
      user = UserInfoSupp.fromSnapshot(data.snapshot);

    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/BackGroundImage.jpg"),fit: BoxFit.cover)),
        child: Scaffold(
          drawer: MainDrawer(),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Home"),
            centerTitle: true,
            backgroundColor: Colors.blueGrey[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async{
                  await _auth.signOut();

                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      SignIn()), (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 36.0),
                    child: NiceButton(
                        elevation: 10.0,
                        radius: 52.0,
                        width: MediaQuery.of(context).size.width*0.80,
                        text: "Hes-so M-Learning",
                        background: Colors.blue.withOpacity(0.2)
                    )
                ),
                Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Center(
                    child: Wrap(
                      spacing: MediaQuery.of(context).size.width*0.10,
                      runSpacing: MediaQuery.of(context).size.height*0.10,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.30,
                          height: MediaQuery.of(context).size.height*0.23,
                          child: GestureDetector(
                            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ThemesList(),
                            )),
                            child: Card(
                              color: Colors.blue.withOpacity(0.1),
                              borderOnForeground: true,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset('assets/theme.png', width: 64.0,),
                                    Text(''),
                                    Text(
                                      'Themes',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "Quiz thèmes ",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.30,
                          height: MediaQuery.of(context).size.height*0.23,
                          child: GestureDetector(
                            onTap: ()=>  Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LanguesList(),
                            )),
                            child: Card(
                              color: Colors.blue.withOpacity(0.1),
                              borderOnForeground: true,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset('assets/Langue.png', width: 64.0,),
                                    Text(''),
                                    Text(
                                      'Langues',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "Quiz langues ",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.30,
                          height: MediaQuery.of(context).size.height*0.23,
                          child: GestureDetector(
                            onTap: ()=> Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Classement(),
                            )),
                            child: Card(
                              color: Colors.blue.withOpacity(0.1),
                              borderOnForeground: true,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset('assets/Calendrier.png', width: 64.0,),
                                    Text(''),
                                    Text(
                                      'Joueur',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "Top joueur",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.30,
                          height: MediaQuery.of(context).size.height*0.23,
                          child: GestureDetector(
                            onTap: ()=> Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Profil(),
                            )),
                            child: Card(
                              color: Colors.blue.withOpacity(0.1),
                              borderOnForeground: true,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset('assets/Information.png', width: 64.0,),
                                    Text(''),
                                    Text(
                                      'Profil',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "Informations",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}