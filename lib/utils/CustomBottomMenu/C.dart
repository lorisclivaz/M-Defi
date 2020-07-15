import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mdefi/screens/home/homeApp.dart';
import 'package:nice_button/NiceButton.dart';

class C extends StatelessWidget {

  int randomValue = 0;

  @override
  Widget build(BuildContext context) {

    randomValue = random(50000, 500000);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/BackGroundImage.jpg"),fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,

          body: Center(
            child: Column(
              children: <Widget>[

                SizedBox(height: 15,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(35.0),
                  child: Image.asset(
                    'assets/lucus.jpg',
                    width: 250.0,
                    height: 250.0,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 50,),
                NiceButton(
                  elevation: 10.0,
                  radius: 52.0,
                  width: MediaQuery.of(context).size.width*0.80,
                  text: 'Café : 600 coinquiz',
                  background: Colors.black45,
                  fontSize: 20,
                  onPressed:(){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20.0)), //this right here
                            child: Container(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Sauvegarder le code suivant $randomValue ? '),
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeApp(),
                                              ));
                                        },
                                        child: Text(
                                          "Save",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.black45,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });


                  },
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}

  random(min, max){
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }