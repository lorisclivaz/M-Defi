import 'package:flutter/material.dart';
import 'package:mdefi/screens/home/homeApp.dart';
import 'package:mdefi/services/auth.dart';
import 'package:mdefi/services/database.dart';
import 'package:nice_button/nice_button.dart';


//HomeUser
class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  final Database database = Database();




  TextEditingController nom = new TextEditingController();
  TextEditingController prenom = new TextEditingController();
  TextEditingController filiere = new TextEditingController();
  TextEditingController ecole = new TextEditingController();
  TextEditingController annee = new TextEditingController();


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text("User information"),
        backgroundColor: Colors.blueGrey[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async{
              await _auth.signOut();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(
            children: <Widget>[

              SizedBox(height: 20.0),
              TextFormField(
                controller: nom,
                decoration: InputDecoration(

                    hintText: 'Nom',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0)
                    )
                ),

              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: prenom,
                decoration: InputDecoration(
                    hintText: 'Prénom',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0)
                    )
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: filiere,
                decoration: InputDecoration(
                    hintText: 'Filière',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0)
                    )
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: ecole,
                decoration: InputDecoration(
                    hintText: 'Ecole',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0)
                    )
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: annee,
                decoration: InputDecoration(
                    hintText: 'Année',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0)
                    )
                ),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'valider',
                  style: TextStyle(color: Colors.white),
                ),

                onPressed: () async {

                 dynamic email = await _auth.getCurrentEmail();
                 dynamic uid = await _auth.getCurrentUID();

                 database.createUser(nom.text, prenom.text, filiere.text, ecole.text, annee.text, email,uid);

                Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomeApp()));



                },

              ),
              NiceButton(
                // width: 515,
                elevation: 8.0,
                radius: 52.0,
                text: "Login",
                background: Colors.blue,
                onPressed: () async {
                  dynamic email = await _auth.getCurrentEmail();
                  dynamic uid = await _auth.getCurrentUID();

                  database.createUser(nom.text, prenom.text, filiere.text, ecole.text, annee.text, email,uid);

                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomeApp()));
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
