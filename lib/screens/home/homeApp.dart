import 'package:mdefi/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/screens/home/home.dart';
import 'package:mdefi/screens/home/mainDrawer.dart';



//HomeApp
class HomeApp extends StatelessWidget {
  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.brown[400],
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
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Incription',
                    style: TextStyle(color: Colors.white),
                  ),

                  onPressed: () async {
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new Home()));

                  },

                ),
                SizedBox(height: 12.0),

              ],
            ),
          )
      ),
    );
  }
}
