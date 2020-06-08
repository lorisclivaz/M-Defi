import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/themes.dart';
import 'package:mdefi/screens/quiz/listquiz.dart';
import 'package:mdefi/services/auth.dart';

class ThemesList extends StatefulWidget {
  @override
  _ThemesListState createState() => _ThemesListState();
}

class _ThemesListState extends State<ThemesList> {

  final AuthService _auth = AuthService();
  final fb = FirebaseDatabase.instance.reference().child("themes");

  //List ou il y aura les données dedans
  List<Themes> list = List();

  //Text de la db
  Text txt ;

  //Methode dînitialisation qui au moment du loading de la page, les données se mettent dans la liste
  @override
  void initState(){
    super.initState();
    fb.once().then((DataSnapshot snap){
      var data = snap.value;
      list.clear();

      data.forEach((key,value){
        Themes themes = new Themes(key, value['Name'], value['ImageUrl'], value['Id']);
        list.add(themes);
      });
      setState(() {

      });

    });
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
                 leading: BackButton(
                   color: Colors.black,
                   onPressed:() => Navigator.of(context).pop() ,
                 ),
                title: Text("Themes"),
                  backgroundColor: Colors.blueGrey[400],
                   elevation: 0.0,

               ),
                           body:new ListView.builder(
                                               itemCount: list.length,
                                               itemBuilder: (context,index){

                               return new SizedBox(
                                 width: 100.0,
                                  height: 320.0,
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
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => QuizList(list[index].id),
        ));

      },

      child: new Card(
        elevation: 10.0,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(16.0),
        ),
        child: new Column(
          children: <Widget>[
            new ClipRRect(
                child: new Image.network(list[index].imageUrl),
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
                    style: Theme.of(context).textTheme.title,
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
