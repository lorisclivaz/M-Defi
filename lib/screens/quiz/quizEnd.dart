import 'package:flutter/material.dart';

class QuizEnd extends StatefulWidget {

  int score;
  int nbrPage;


  QuizEnd(this.score, this.nbrPage);

  @override
  _QuizEndState createState() => _QuizEndState();
}

class _QuizEndState extends State<QuizEnd> {
  @override
  Widget build(BuildContext context) {

    print(widget.score);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/BackGroundImage.jpg"),fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[400],
              title: Text("Score"),
              actions: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.close),
                  onPressed: () =>
                      print('Annulation du quiz')
                  ,
                ),
              ],
              leading: new Container(),
            ),
          ),
        )
    );
  }
}
