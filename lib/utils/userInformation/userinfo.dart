
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/userInfoSupp.dart';
import 'package:mdefi/services/auth.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {

  final AuthService _auth = AuthService();
  final fb = FirebaseDatabase.instance.reference().child("users");

  String currentUid;
  UserInfoSupp user;
  List<UserInfoSupp> list = List();

  @override
  void initState(){
    super.initState();


    //Chargement de l'uid de l'utilisateur
    _auth.getCurrentUID().then((String value){
      currentUid = value;
    });


    fb.once().then((DataSnapshot snap){
      var data = snap.value;
      list.clear();
      data.forEach((key,value){
        user = new UserInfoSupp(key,value['Uid'], value['Email'], value['Annee'], value['Ecole'], value['Filiere'], value['Nom'], value['Prenom']);
        list.add(user);
      });

      setState(() {

      });
    });



  }

  @override
  Widget build(BuildContext context) {

    UserInfoSupp dataFields ;

    dataFields = list.singleWhere((tempSB) => tempSB.uid==currentUid);

    print(dataFields.nom);
    print(dataFields.prenom);



    return Scaffold(

      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed:() => Navigator.of(context).pop() ,
        ),
        backgroundColor: Colors.blueGrey[400],
        elevation: 0.0,
        title: Text('Information'),
        actions: <Widget>[

        ],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: dataFields.nom,
                      fillColor: Colors.white,
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
                  decoration: InputDecoration(
                      hintText: dataFields.prenom,
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

                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: dataFields.email,
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

                ),
                SizedBox(height: 20.0),

                TextFormField(
                  decoration: InputDecoration(
                      hintText: dataFields.ecole,
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

                ),
                SizedBox(height: 20.0),

                TextFormField(
                  decoration: InputDecoration(
                      hintText: dataFields.filiere,
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

                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: dataFields.annee,
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
                ),
                SizedBox(height: 12.0),

              ],
            ),
          )
      ),
    );



  }
}



