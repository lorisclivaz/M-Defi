import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:mdefi/models/userInfoSupp.dart';
import 'package:mdefi/screens/Themes/langueList.dart';
import 'package:mdefi/screens/Themes/themesList.dart';
import 'package:mdefi/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/services/database.dart';
import 'package:mdefi/utils/about/about.dart';
import 'package:mdefi/utils/mainDrawer.dart';
import 'package:nice_button/NiceButton.dart';




//HomeApp
class HomeApp extends StatelessWidget {

  //Variables de la classe HomeApp
  final AuthService _auth = AuthService();
  final DBRef = FirebaseDatabase.instance.reference();
  static String email ;
  static String uid ;
  static UserInfoSupp user;
  Database database = new Database();

  @override
  Widget build(BuildContext context) {



    //Chargement du mail de l'utilisateur
    _auth.getCurrentEmail().then((String result){
      email = result;
    });

    //Chargement de l'uid de l'utilisateur
    _auth.getCurrentUID().then((String value){
      uid = value;
    });

    //Chargement de toute les informations personnelles de l'utilisateur
    DBRef.child('users').orderByChild('Uid').equalTo(uid).onChildAdded.listen((data){
      user = UserInfoSupp.fromSnapshot(data.snapshot);

    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/BackGroundImage.jpg"),fit: BoxFit.cover)),
        child: Scaffold(
          drawer: MainDrawer(),
          backgroundColor: Colors.transparent,
          appBar: AppBar(

            title: Text("Home"),
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
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 36.0),
                  child: NiceButton(
                      elevation: 10.0,
                      radius: 52.0,
                      width: MediaQuery.of(context).size.width*0.80,
                      text: "Hes-so M-Learning",
                      background: Colors.blue.withOpacity(0.2)
                  )
                  ),
                Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Center(
                    child: Wrap(
                      spacing: MediaQuery.of(context).size.width*0.10,
                      runSpacing: MediaQuery.of(context).size.height*0.10,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.30,
                          height: MediaQuery.of(context).size.height*0.23,
                          child: GestureDetector(
                            onTap: ()=> Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ThemesList(),
                            )),
                            child: Card(
                              color: Colors.blue.withOpacity(0.1),

                              borderOnForeground: true,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset('assets/theme.png', width: 64.0,),
                                    Text(''),
                                    Text(
                                      'Themes',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "Quiz thèmes ",
                                      style: TextStyle(

                                          color: Colors.white,

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.30,
                          height: MediaQuery.of(context).size.height*0.23,
                          child: GestureDetector(
                            onTap: ()=> Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LanguesList(),
                            )),
                            child: Card(
                              color: Colors.blue.withOpacity(0.1),

                              borderOnForeground: true,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset('assets/Langue.png', width: 64.0,),
                                    Text(''),
                                    Text(
                                      'Langues',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "Quiz langues ",
                                      style: TextStyle(

                                        color: Colors.white,

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.30,
                          height: MediaQuery.of(context).size.height*0.23,
                          child: GestureDetector(
                            onTap: ()=> print("Salut"),
                            child: Card(
                              color: Colors.blue.withOpacity(0.1),

                              borderOnForeground: true,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset('assets/Calendrier.png', width: 64.0,),
                                    Text(''),
                                    Text(
                                      'Agenda',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "Rappel",
                                      style: TextStyle(

                                        color: Colors.white,

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.30,
                          height: MediaQuery.of(context).size.height*0.23,
                          child: GestureDetector(
                            onTap: ()=> Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => About(),
                            )),
                            child: Card(
                              color: Colors.blue.withOpacity(0.1),

                              borderOnForeground: true,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset('assets/Information.png', width: 64.0,),
                                    Text(''),
                                    Text(
                                      'A propos',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "Informations",
                                      style: TextStyle(

                                        color: Colors.white,

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),


                  ),

                )

              ],

            ),
          ),


        ),
      ),

    );


  }


}
