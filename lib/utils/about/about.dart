/*
 * Author : Loris Clivaz
 * Date creation : 09 juin 2020
 */

import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';


/*
 * Classe qui va donner les informations de l'application M-Learning
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class About extends StatefulWidget {
  @override
  _AboutListState createState() => _AboutListState();
}

class _AboutListState extends State<About> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Dispose about page");
  }
  //Design de la page
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
                          width: MediaQuery.of(context).size.width*0.70,
                          background: Colors.blue.withOpacity(0.2),
                        fontSize: 25,
                        text: 'M-Learning',
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
