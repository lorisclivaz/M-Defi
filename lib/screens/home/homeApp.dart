import 'package:firebase_database/firebase_database.dart';
import 'package:mdefi/models/userInfoSupp.dart';
import 'package:mdefi/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/utils/mainDrawer.dart';



//HomeApp
class HomeApp extends StatelessWidget {
  final AuthService _auth = AuthService();
  final DBRef = FirebaseDatabase.instance.reference();

  static String email ;
  static String uid ;
  static UserInfoSupp user;


  @override
  Widget build(BuildContext context) {

    _auth.getCurrentEmail().then((String result){
      email = result;
    });

    _auth.getCurrentUID().then((String value){
      uid = value;
    });

    DBRef.child('users').orderByChild('Uid').equalTo(uid).onChildAdded.listen((data){
      user = UserInfoSupp.fromSnapshot(data.snapshot);

    });


    //Trouver une meilleure solution pour l'inscription de l'utilisateur
  //Future.delayed(Duration.zero, () => showAlertDialog(context));
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      drawer: MainDrawer(),
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
    );

  }


}
