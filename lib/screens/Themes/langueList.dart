import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/themes.dart';
import 'package:mdefi/screens/quiz/listquiz.dart';
import 'package:mdefi/services/auth.dart';

class LanguesList extends StatefulWidget {
  @override
  _LanguesListState createState() => _LanguesListState();
}

class _LanguesListState extends State<LanguesList> {

  final AuthService _auth = AuthService();
  final fb = FirebaseDatabase.instance.reference().child("langues");

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
    print(list.length);
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
              title: Text("Langues"),
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
    print(list[index].imageUrl);
    return GestureDetector(
      onTap: (){
        print('langue');

      },


      child: new Card(
        color: Colors.blue.withOpacity(0.2),
        elevation: 10.0,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(16.0),
        ),
        child: new Column(
          children: <Widget>[
            new ClipRRect(
                child: new Image.asset(list[index].imageUrl,height: 180,width: 180,),
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
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      )
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