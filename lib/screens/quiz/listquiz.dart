import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/quiz.dart';
import 'package:mdefi/services/auth.dart';

class QuizList extends StatefulWidget {

  final String idTheme;

  const QuizList(this.idTheme);


  @override
  _listQuizState createState() => _listQuizState();
}

class _listQuizState extends State<QuizList> {

  final AuthService _auth = AuthService();
  final fb = FirebaseDatabase.instance.reference().child("quiz");


  //List ou il y aura les données dedans
  List<Quiz> list = List();

  //Methode dînitialisation qui au moment du loading de la page, les données se mettent dans la liste
  @override
  void initState(){
    super.initState();
    fb.once().then((DataSnapshot snap){
      var data = snap.value;
      list.clear();

      data.forEach((key,value){
        Quiz quizs = new Quiz(key, value['Id'], value['Name'], value['IdTheme']);
        if(quizs.idTheme == widget.idTheme)
          {
            list.add(quizs);
          }
      });
      setState(() {

      });

    });
  }

  @override
  Widget build(BuildContext context) {

   print(list.length);



    return  MaterialApp(
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
              title: Text("Quiz"),
              backgroundColor: Colors.blueGrey[400],
              elevation: 0.0,

            ),
            body:new ListView.builder(
              itemCount: list.length,
              itemBuilder: (context,index){

                return new SizedBox(
                  width: 100.0,
                  height: 120.0,
                  child: Container(
                    padding: EdgeInsets.only(bottom:30.0,left: 20,right: 20,top: 25),
                    child: ui(index),
                  ),
                );
              },
            ),
          ),


        )
    );
  }

  Widget ui(int index){
    return GestureDetector(
      onTap: (){
        print(list[index].id);


      },

      child: new Card(
        elevation: 10.0,
        color: Colors.white30,
          shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(16.0),
        ),
        child: new Column(
          children: <Widget>[
            new ClipRRect(
                child: new Image.network(list[index].name),
                borderRadius: BorderRadius.only(
                  topLeft: new Radius.circular(16.0),
                  topRight: new Radius.circular(16.0),
                )
            ),
            new Padding(
              padding: new EdgeInsets.all(16.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  new Text(
                    list[index].name.toUpperCase(),
                    style: Theme.of(context).textTheme.body2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
