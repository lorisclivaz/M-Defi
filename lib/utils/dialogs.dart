import 'package:flutter/material.dart';
import 'package:mdefi/screens/home/home.dart';

class Dialogs
{
  information(BuildContext context, String title, String description){
    return showDialog(context: context,
    barrierDismissible: true,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(description)
            ],
          ),
      ),
        actions: <Widget>[
          FlatButton(
            onPressed:  () async => Navigator.push(context, new MaterialPageRoute(builder: (context) => new Home())),
            child: Text('inscription'),

          )
        ],
      );
    });
  }
}