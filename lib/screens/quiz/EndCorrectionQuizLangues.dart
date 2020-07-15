import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/CorrectionQuizLangues.dart';
import 'package:mdefi/screens/home/homeApp.dart';
import 'package:mdefi/services/database.dart';

class EndCorrectionQuizLangues extends StatefulWidget {

  @override
  _EndCorrectionQuizLanguesState createState() => _EndCorrectionQuizLanguesState();

}

class _EndCorrectionQuizLanguesState extends State<EndCorrectionQuizLangues> {

  //Référence base  de données
  final fb = FirebaseDatabase.instance.reference().child("CorrectionQuizLangues");

  //Listes où il y aura les données dedans
  List<CorrectionQuizLanguesModel> list = List();

  //Variable pour la base de données
  Database db = new Database();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Récupération de la correction des questions
    fb.once().then((DataSnapshot snap) {
      var data = snap.value;
      list.clear();
      data.forEach((key, value) {
        CorrectionQuizLanguesModel correctionQuizModel = new CorrectionQuizLanguesModel(
            key,
            value['Name1'],
            value['Name2'],
            value['NombrePage'],
            value['Reponse'],
            value['ReponseUser']);

        list.add(correctionQuizModel);

      });
      if(mounted)
      {
        setState(() {

        });
      }
    });


  }

  @override
  Widget build(BuildContext context) {

    //Trier la liste du plus petit au plus grand
    if(list.length > 0)
    {
      list.sort((a,b) => a.nombrePage.compareTo(b.nombrePage));
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/BackGroundImage.jpg"),fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(

            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.home),
                label: Text('Home'),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      HomeApp()), (Route<dynamic> route) => false);

                  db.DeleteCorrectionQuizLangues();
                },
              ),
            ],
            title: Text("Correction du quiz"),
            centerTitle: true,
            backgroundColor: Colors.blueGrey[400],
            elevation: 0.0,
          ),
          body: new ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            itemBuilder: (context,index){

              return new SizedBox(
                width: 100.0,
                height: 300.0,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Material(
                          color: Colors.white38,
                          elevation: 14.0,
                          borderRadius: BorderRadius.circular(24.0),
                          shadowColor: Colors.white30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          "Question "+list[index].nombrePage.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 8.0,
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.underline
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                        width: MediaQuery.of(context).size.width*0.15,
                                        child:  Text(
                                          list[index].name1+'....'+list[index].name2,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 3,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      SizedBox(
                                        height: 12,
                                        width: MediaQuery.of(context).size.width*0.10,
                                        child:  Text(
                                          "Réponse : "+list[index].reponse,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 3.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height: 2,
                                          width: MediaQuery.of(context).size.width*0.10,
                                          child: icons(context,index)

                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ),
                  ),
                ),

              );
            },
          ),

        ),
      ),


    );

  }
  Widget icons (BuildContext context,int index)
  {

    Widget child;
    if(list[index].reponseUser.toString() == '0')
    {
      print("salut");
      child = Icon(Icons.beenhere, size: 10);

    }else
    {
      print("salut 2");
      child = Icon(Icons.cancel, size: 10);

    }

    return child;
  }
}
