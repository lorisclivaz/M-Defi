import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/ClassementModel.dart';
import 'package:mdefi/screens/home/homeApp.dart';

import 'A.dart';
import 'B.dart';
import 'C.dart';

class CustomBottomBar extends StatefulWidget {
  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  var _page = 0;


  final fbThemes = FirebaseDatabase.instance.reference().child("ClassementUsersThemes");
  final fbLangues = FirebaseDatabase.instance.reference().child("ClassementUsersLangues");

  //Récupération des infos de classement
  List<ClassementModel> listThemes = List();
  List<ClassementModel> listLangues = List();

  //Final user par rapport à toutes les données dans la db
  ClassementModel dataFieldsThemes = new ClassementModel('', 0, '', 0, 0, 0);
  ClassementModel dataFieldsLangues = new ClassementModel('', 0, '', 0, 0, 0);

  //CoinQuiz
  static int totalCoinQuiz = 0;
  final pages = [A(totalCoinQuiz),B(),C()];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
            value['Score']);

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
            value['Score']);

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

  @override
  Widget build(BuildContext context) {

    totalCoinQuiz = dataFieldsLangues.coinQuiz + dataFieldsThemes.coinQuiz;

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
            title: Text("Bon d'achat"),
            backgroundColor: Colors.blueGrey[400],
            elevation: 0.0,
          ),

          bottomNavigationBar: CurvedNavigationBar(
            color: Colors.white30,
              backgroundColor: Colors.white24,
              buttonBackgroundColor: Colors.blueGrey,
              items: <Widget>[
                Icon(Icons.fastfood, size: 20, color: Colors.black),
                Icon(Icons.local_drink, size: 20, color: Colors.black),
                Icon(Icons.cake, size: 20, color: Colors.black)
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
