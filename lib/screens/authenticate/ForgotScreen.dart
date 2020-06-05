import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/screens/home/homeApp.dart';
import 'package:mdefi/shared/loading.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:mdefi/services/database.dart';


class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() {
    return _ForgotScreenState();
  }
}

class _ForgotScreenState extends State<ForgotScreen> {

  final Database database = Database();

  final myController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        elevation: 0.0,
        title: Text('Mot de passe '),

      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.only(top: 50, left: 20, right: 20),

          child: Column(
            children: <Widget>[

              Text("Nous allons vous envoyer un lien, Veuillez cliquer dessus afin de réinitialiser votre mot de passe",
              style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Text(''),
              Text(''),

              Theme(
                data: ThemeData(
                  hintColor: Colors.blueGrey
                ),

                  child: TextFormField(
                    controller: myController,
                      validator: (val) => val.toString() != HomeApp.email ? 'Entrer un mail valide' : null,

                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.black,width: 1)
                    )
                  ),
                ),
              ),
              Text(''),
              Text(''),
              Text(''),
              NiceButton(
                // width: 515,
                elevation: 8.0,
                radius: 52.0,
                text: "Envoyer",
                background: Colors.blue,
                onPressed: () async {

                  if(myController.text == HomeApp.email)
                    {
                      setState (() => loading = true);
                      FirebaseAuth.instance.sendPasswordResetEmail(email: myController.text).then((value)=> print("Veuillez vérifier vos emails"));
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeApp(),
                      ));
                    }else{
                    print('not valid mail');
                  }



                  },
              ),
            ],
          ),


        ),

      ),

    );
  }
}

