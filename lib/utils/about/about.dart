import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/themes.dart';
import 'package:mdefi/screens/quiz/listquiz.dart';
import 'package:mdefi/services/auth.dart';
import 'package:nice_button/NiceButton.dart';

class About extends StatefulWidget {
  @override
  _AboutListState createState() => _AboutListState();
}

class _AboutListState extends State<About> {


  //Methode dînitialisation qui au moment du loading de la page, les données se mettent dans la liste

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
              title: Text("Information"),
              backgroundColor: Colors.blueGrey[400],
              elevation: 0.0,

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
                          width: 600,
                          text: "Bienvenue sur M-Learning",
                          background: Colors.blue.withOpacity(0.2)
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.all(18.0),

                    child: Center(

                      child: Container(
                        child: SizedBox(
                          width: 400.0,
                          height: 400.0,
                          child: Card(
                            color: Colors.blue.withOpacity(0.1),
                            child: Text(
                              "M-Learning est un prototype encadré par la Hes-so Valais. Dans le but du travail de bachelor, cette application "
                                  "doit servir aux différents étudiants de la hes afin d'apprendre des notions utile aux modules fournis."
                                  "Ca fonctionalité principale est de créer un système de quiz interactif avec différentes questions sur les thèmes abordé en cours.",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0
                              ),
                            ),

                          ),
                        ),
                      ),
                    ),
                  ),
                ],

              ),

            ),

          ),


        ),
    );
  }

}
