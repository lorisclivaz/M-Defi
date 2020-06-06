import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/userInfoSupp.dart';
import 'package:mdefi/screens/authenticate/ForgotScreen.dart';
import 'package:mdefi/screens/home/homeApp.dart';
import 'package:mdefi/services/auth.dart';
import 'package:nice_button/NiceButton.dart';


class ProfileScreen extends StatelessWidget {

  final AuthService _auth = AuthService();

    @override
  Widget build(BuildContext context) {

    //Create user info
    Widget _userInfo(){

      return Positioned(
        top: 50,
        child: Container(
          margin: const EdgeInsets.all(20),
          height: 280,
          width: MediaQuery.of(context).size.width*0.9,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black),

          ),
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(children: <Widget>[
              Text("Mes informations", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
              decoration: TextDecoration.underline),
              ),
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(radius: 60,),
                  SizedBox(width: 20,),
                  Text(HomeApp.user.prenom),
                  SizedBox(width: 20,),
                  Text(HomeApp.user.nom),

                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text( HomeApp.user.email,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
            ],),
          ),
        ),
      );
    }

    Widget _userInfo2()
    {
      return Positioned(
        top: 370,
        child: Container(margin: EdgeInsets.all(20),
          height: 280,
          width: MediaQuery.of(context).size.width * 0.9 ,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black),
            color: Colors.white,
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Information supplémentaires", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    decoration: TextDecoration.underline)
                ),
                SizedBox(height: 20,),
                Text("Ecole : "+ HomeApp.user.ecole),
                SizedBox(height: 20,),
                Text("Filière : "+ HomeApp.user.filiere),
                SizedBox(height: 20,),
                Text("Année : "+ HomeApp.user.annee),
                Text(''),
                Text(''),
                NiceButton(
                  // width: 515,
                  elevation: 30.0,
                  radius: 52.0,
                  text: "Change password",
                  background: Colors.blue,
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ForgotScreen(),
                    ));
                                     },
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          title: Text("Mon profil"),

          backgroundColor: Colors.blueGrey[400],
          elevation: 0.0,
          actions: <Widget>[
          ],
        ),
      body:
        SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
             color: Colors.blueGrey[100],
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                //Mettre une image en background
                ),

              _userInfo(),
              _userInfo2(),
            ],
          ),
        )



    );

  }


}
