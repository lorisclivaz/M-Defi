import 'package:mdefi/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/screens/home/home.dart';
import 'package:mdefi/utils/mainDrawer.dart';
import 'package:mdefi/utils/dialogs.dart';



//HomeApp
class HomeApp extends StatelessWidget {
  final AuthService _auth = AuthService();
  final dialog = new Dialogs();


  @override
  Widget build(BuildContext context) {
    //Trouver une meilleure solution pour l'inscription de l'utilisateur
  //Future.delayed(Duration.zero, () => showAlertDialog(context));
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      drawer: MainDrawer(),
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
    );

  }

  void showAlertDialog(BuildContext context) {

    dialog.information(context, 'Inscription', 'Veuillez vous inscrire avant de poursuivre');
  }
}
