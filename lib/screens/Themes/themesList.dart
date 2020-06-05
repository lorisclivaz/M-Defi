import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/themes.dart';
import 'package:mdefi/services/auth.dart';

class ThemesList extends StatefulWidget {
  @override
  _ThemesListState createState() => _ThemesListState();
}

class _ThemesListState extends State<ThemesList> {
  final AuthService _auth = AuthService();
  final fb = FirebaseDatabase.instance.reference().child("themes");

  List<Themes> list = List();
  
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

    Widget UI(String key, String name, String ImageUrl, String id){
      return Container(

          height: 200,
          child:GestureDetector(

            onLongPress: (){
              print("j'appui longtemps");
            },
            onTap: (){
              print("salut");
            },

            child: Card(

              child: Column(
                children: <Widget>[

                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ImageUrl,
                    style: TextStyle(
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    id,
                    style: TextStyle(
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),

          )

      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Thèmes"),
        backgroundColor: Colors.blueGrey[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async{
              await _auth.signOut();
            },
          ),
        ],
      ),

      body: new Container(
        child: list.length == 0 ? Text("Il n'y a aucune données"): ListView.builder(
          itemCount: list.length,
            itemBuilder: (_,index){
            return UI(list[index].key, list[index].name, list[index].imageUrl, list[index].id);
            }
        ),
      ),
    );
  }

  Widget container(){
    return Material(
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(24.0),
      ),
    );
  }
}
