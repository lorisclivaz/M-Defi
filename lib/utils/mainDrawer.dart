/*
 * Author : Loris Clivaz
 * Date creation : 07 juin 2020
 */

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/userInfoSupp.dart';
import 'package:mdefi/screens/home/homeApp.dart';
import 'package:mdefi/services/database.dart';
import 'package:mdefi/utils/CustomBottomMenu/CustomBottomBar.dart';
import 'package:mdefi/utils/userInformation/informations.dart';

/*
 * Classe qui va gérer la navigation sur la gauche de l'application
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class MainDrawer extends StatelessWidget {

  Database db = new Database();
  final fb = FirebaseDatabase.instance.reference().child("users");
  List<UserInfoSupp> users = List();


  //Design de la page
  @override
  Widget build(BuildContext context) {
    userExist();

    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color:Colors.blueGrey[400],
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 30,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/logo.jpg'
                            ),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                  Text(
                    HomeApp.email,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Inscription',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              if(users.isEmpty)
              {
                db.createUser('', '', '', '', '', HomeApp.email, HomeApp.uid);
              }
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Information(),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text(
              "Bon d'achat",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CustomBottomBar(),
              ));
            },
          )
        ],
      ),
    );
  }

  void userExist(){
    //Récupération des questions
    fb.once().then((DataSnapshot snap) {
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