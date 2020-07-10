import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'A.dart';
import 'B.dart';
import 'C.dart';

class CustomBottomBar extends StatefulWidget {
  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  var _page = 0;
  final pages = [A(),B(),C()];
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
