import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/services/auth.dart';
import 'package:mdefi/models/userInfoSupp.dart';



class ProfileScreen extends StatelessWidget {

  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {

    //Create user info
    Widget _userInfo(){
      return Positioned(
        top: 100,
        child: Container(
          margin: const EdgeInsets.all(20),
          height: 260,
          width: MediaQuery.of(context).size.width*0.9,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(children: <Widget>[
              Text("User information", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(radius: 60,),
                  SizedBox(width: 20,),
                  Text("Firstname"),
                  SizedBox(width: 20,),
                  Text("LastName"),

                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text("Email: ",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
            ],),
          ),
        ),
      );
    }

    Widget _userInfo2()
    {
      return Positioned(
        top: 400,
        child: Container(margin: EdgeInsets.all(20),
          height: 200,
          width: MediaQuery.of(context).size.width * 0.9 ,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("user info 2", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                ),
                SizedBox(height: 20,),
                Text("Ecole : "+ "asdfadsf"),
                SizedBox(height: 20,),
                Text("Ecole : "+ "asdfadsf"),
                SizedBox(height: 20,),
                Text("Ecole : "+ "asdfadsf")
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
