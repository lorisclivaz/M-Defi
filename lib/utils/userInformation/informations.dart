import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/userInfoSupp.dart';
import 'package:mdefi/screens/authenticate/ForgotScreen.dart';
import 'package:mdefi/screens/home/homeApp.dart';
import 'package:mdefi/services/auth.dart';
import 'package:mdefi/services/database.dart';
import 'package:nice_button/NiceButton.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {

  final AuthService _auth = AuthService();
  final fb = FirebaseDatabase.instance.reference().child("users");
  Database updateUser = Database();
  String currentUid;
  UserInfoSupp user = new UserInfoSupp('','', '', '', '', '',
      '', '');
  UserInfoSupp dataFields = new UserInfoSupp('','', '', '', '', '',
      '', '');
  List<UserInfoSupp> list = List();


  TextEditingController nom = new TextEditingController();
  TextEditingController prenom = new TextEditingController();
  TextEditingController ecole = new TextEditingController();
  TextEditingController filiere = new TextEditingController();
  TextEditingController annee = new TextEditingController();


  @override
  void initState (){
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

      dataFields = list.singleWhere((tempSB) => tempSB.uid==currentUid);


      setState(() {
      });
    });



  }

  Widget ui(){

  }

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
                  controller: nom,
                  decoration: InputDecoration(
                    labelText: 'Nom : '+dataFields.nom,
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
                  controller: prenom,
                  decoration: InputDecoration(
                    labelText: 'Prénom : '+dataFields.prenom,
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


                ),
                SizedBox(height: 20.0),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Email : '+dataFields.email,
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


                ),
                SizedBox(height: 20.0),

                TextFormField(
                  controller: ecole,
                  decoration: InputDecoration(
                    labelText: 'Ecole : '+dataFields.ecole,
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


                ),
                SizedBox(height: 20.0),

                TextFormField(
                  controller: filiere,
                  decoration: InputDecoration(
                    labelText: 'Filière : '+dataFields.filiere,
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


                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: annee,
                  decoration: InputDecoration(
                    labelText: 'Année : '+dataFields.annee,
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

                ),
                SizedBox(height: 12.0),
                NiceButton(
                  // width: 515,
                  elevation: 5.0,
                  radius: 40.0,
                  text: "mot de passe",
                  background: Colors.blue,
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ForgotScreen(),
                    ));              },
                ),
                SizedBox(height: 12.0),

                NiceButton(
                  // width: 515,
                  elevation: 5.0,
                  radius: 40.0,
                  text: "Modifier",
                  background: Colors.blue,
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
                    ));              },
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

