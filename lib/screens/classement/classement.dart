/*
 * Author : Loris Clivaz
 * Date creation : 13 juillet 2020
 */

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/screens/classement/ClassementCoinQuiz.dart';
import 'package:mdefi/screens/classement/ClassementPoint.dart';
import 'package:mdefi/screens/classement/classementScore.dart';

/*
 * Classe de classement
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */
class Classement extends StatefulWidget {



  @override
  _ClassementState createState() => _ClassementState();
}

class _ClassementState extends State<Classement> {

  //variable classement screens
  var _page = 0;
  final pages = [ClassementScore(), ClassementCoinQuiz(), ClassementPoint()];

  //Methode permettant de supprimer le state de la page
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose classement");
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
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back),
        onPressed: () {
         Navigator.pop(context);
        },
      ),
    title: Text("Classement"),
    centerTitle: true,
    backgroundColor: Colors.blueGrey[400],
    elevation: 0.0,
    ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white30,
        backgroundColor: Colors.white24,
        buttonBackgroundColor: Colors.blueGrey,
        items: <Widget>[
          Column(
            children: <Widget>[
              Icon(Icons.score, size: 30, color: Colors.black,),
              Text("Score")

            ],
          ),
          Column(
            children: <Widget>[
              Icon(Icons.monetization_on, size: 30, color: Colors.black),
              Text("CoinQuiz")

            ],
          ),
          Column(
            children: <Widget>[
              Icon(Icons.control_point, size: 30, color: Colors.black),
              Text("Points +")
            ],
          )
        ],
        animationDuration: Duration(
            milliseconds: 200
        ),
        index: 0,
        animationCurve: Curves.bounceInOut,
        onTap: (index){
          setState(() {
            _page=index;
          });

        },

      ),
      body: pages[_page],
    ),
    ),
    );
  }

}
