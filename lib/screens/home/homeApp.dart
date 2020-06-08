import 'package:firebase_database/firebase_database.dart';
import 'package:mdefi/models/userInfoSupp.dart';
import 'package:mdefi/screens/Themes/themesList.dart';
import 'package:mdefi/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/utils/mainDrawer.dart';
import 'package:nice_button/NiceButton.dart';




//HomeApp
class HomeApp extends StatelessWidget {

  //Variables de la classe HomeApp
  final AuthService _auth = AuthService();
  final DBRef = FirebaseDatabase.instance.reference();
  static String email ;
  static String uid ;
  static UserInfoSupp user;

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
            backgroundColor: Colors.blueGrey[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async{
                  await _auth.signOut();
                },
              ),
            ],
          ),
          body: Container(
            child:  NiceButton(
              // width: 515,
              elevation: 5.0,
              radius: 40.0,
              text: "Themes",
              background: Colors.blue,
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ThemesList(),
                ));              },
            ),
          ),
        ),
      ),
    );


  }


}
