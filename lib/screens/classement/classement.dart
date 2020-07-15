import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/screens/classement/ClassementCoinQuiz.dart';
import 'package:mdefi/screens/classement/ClassementPoint.dart';
import 'package:mdefi/screens/classement/classementScore.dart';

class Classement extends StatefulWidget {



  @override
  _ClassementState createState() => _ClassementState();
}

class _ClassementState extends State<Classement> {

  //Page de classement
  var _page = 0;
  final pages = [ClassementScore(), ClassementCoinQuiz(), ClassementPoint()];

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose classement");
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
          Icon(Icons.score, size: 30, color: Colors.black,),
          Icon(Icons.monetization_on, size: 30, color: Colors.black),
          Icon(Icons.control_point, size: 30, color: Colors.black)
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
