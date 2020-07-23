/*
 * Author : Loris Clivaz
 * Date creation : 16 juillet 2020
 */

import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:mdefi/models/ClassementModel.dart';
import 'package:mdefi/models/userInfoSupp.dart';
import 'package:mdefi/screens/home/homeApp.dart';
import 'package:mdefi/services/auth.dart';
import 'package:mdefi/services/database.dart';
import 'package:mdefi/utils/userInformation/informations.dart';

/*
 * Classe de profil utilisateur
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */
class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}


class _ProfilState extends State<Profil> {

  //Variable de la base de données
  final fb = FirebaseDatabase.instance.reference().child("users");
  final fbThemes = FirebaseDatabase.instance.reference().child("ClassementUsersThemes");
  final fbLangues = FirebaseDatabase.instance.reference().child("ClassementUsersLangues");
  Database db = new Database();
  final fbUser = FirebaseDatabase.instance.reference().child("users");


  //Variables utilisateur
  String prenom = 'Compléter';
  String nom = 'Compléter';
  String scoreThemes = '0';
  String scoreLangues = '0';
  String email;
  String coinQuiz = '0';


  //Récupération des infos utilisateurs
  UserInfoSupp user = new UserInfoSupp('','', '', '', '', '',
      '', '');
  UserInfoSupp dataFields = new UserInfoSupp('','', '', '', '', '',
      '', '');
  String currentUid;

  //Récupération des infos de classement
  List<ClassementModel> listThemes = List();
  List<ClassementModel> listLangues = List();
  List<UserInfoSupp> users = List();


  //Final user par rapport à toutes les données dans la db
  ClassementModel dataFieldsThemes = new ClassementModel('', 0, '', 0, 0, 0,'');
  ClassementModel dataFieldsLangues = new ClassementModel('', 0, '', 0, 0, 0,'');


  //Variable current user
  final AuthService _auth = AuthService();
  List<UserInfoSupp> list = List();

  //Total coinquiz
  int totalCoinquiz;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
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

    //Récupération des themes
    fbThemes.once().then((DataSnapshot snap) {
      var data = snap.value;
      listThemes.clear();
      data.forEach((key, value) {
        ClassementModel classement = new ClassementModel(
            key,
            value['CoinQuiz'],
            value['Email'],
            value['PointNegatif'],
            value['PointPositif'],
            value['Score'],
            value['NomQuiz']);

        listThemes.add(classement);
      });
      //Ajout d'informations dans la list avec condition
      dataFieldsThemes = listThemes.singleWhere((tempSB) => tempSB.email==HomeApp.email);
      setState(() {
      });
      if(mounted)
      {
        setState(() {

        });
      }
    });

    //Récupération des langues
    fbLangues.once().then((DataSnapshot snap) {
      var data = snap.value;
      listLangues.clear();
      data.forEach((key, value) {
        ClassementModel classement = new ClassementModel(
            key,
            value['CoinQuiz'],
            value['Email'],
            value['PointNegatif'],
            value['PointPositif'],
            value['Score'],
            value['NomQuiz']);

        listLangues.add(classement);

      });
      dataFieldsLangues = listLangues.singleWhere((tempSB) => tempSB.email==HomeApp.email);

      if(mounted)
      {
        setState(() {

        });
      }
    });

  }

  //Design de la page
  @override
  Widget build(BuildContext context) {

    userExist();

    totalCoinquiz = dataFieldsLangues.coinQuiz + dataFieldsThemes.coinQuiz;

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/BackGroundImage.jpg"),fit: BoxFit.cover),

        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text("Profil"),
        backgroundColor: Colors.blueGrey[400],
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.add),
              tooltip: "ajouter",
              color: Colors.white,
              onPressed: (){
                if(users.isEmpty)
                {
                  db.createUser('', '', '', '', '', HomeApp.email, HomeApp.uid);
                }
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Information(),
                ));
              },
            ),
          )
        ],
      ),
          body: Form(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      gradient: LinearGradient(
                          colors: [
                            Colors.lightBlue,
                            Colors.teal[200],
                          ]
                      )
                    ),
                    child: Column(
                      children:<Widget>[
                        SizedBox(height:70 ,),
                        Container(
                          height: 100,
                          width: 100,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2,color: Colors.white),
                            shape: BoxShape.circle
                          ),
                          child: Container(
                            height: 80,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Colors.white),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage("assets/user.png"),
                                  fit: BoxFit.cover
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(dataFields.prenom+" "+ dataFields.nom, style: TextStyle(
                          fontSize: 32,
                          color: Colors.white
                        ),),
                        Text(dataFields.uid, style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87
                        ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                                Expanded(
                                  child: Container(
                                    color: Colors.white38.withOpacity(0.3),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(dataFieldsThemes.score.toString(), style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22
                                        ),),
                                        Text("Score thèmes"),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.white30.withOpacity(0.4),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(dataFieldsLangues.score.toString(),style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22
                                        ),),
                                        Text("Score langues"),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        )
                      ]
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                   // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15,),
                      Text("Email",style: TextStyle(
                        fontSize: 28,
                        color: Colors.cyan,
                        decoration: TextDecoration.underline
                      ),),
                      Text(dataFields.email,style: TextStyle(
                        fontSize: 22,
                        color: Colors.white
                      ),),
                      SizedBox(height: 30,),
                      Text("Filière",style: TextStyle(
                          fontSize: 28,
                          color: Colors.cyan,
                          decoration: TextDecoration.underline

                      ),),
                      Text(dataFields.filiere,style: TextStyle(
                          fontSize: 22,
                          color: Colors.white
                      ),),
                      SizedBox(height: 30,),
                      Text("CoinQuiz",style: TextStyle(
                          fontSize: 28,
                          color: Colors.cyan,
                          decoration: TextDecoration.underline

                      ),),
                      Text(totalCoinquiz.toString(),style: TextStyle(
                          fontSize: 22,
                          color: Colors.white
                      ),),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Methode détectant si l'utilisateur existe ou pas
  void userExist(){
    //Récupération des questions
    fbUser.once().then((DataSnapshot snap) {
      var data = snap.value;
      users.clear();

      data.forEach((key, value) {
        UserInfoSupp user = new UserInfoSupp(
            key,
            value['Uid'],
            value['Email'],
            value['Annee'],
            value['Ecole'],
            value['Filiere'],
            value['Nom'],
            value['Prenom']);
        if (HomeApp.uid == user.uid) {
          users.add(user);
        }
      });

    });
  }
}
