import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/reponse.dart';

class dropDown extends StatefulWidget {

 final List<ReponseQuestion> list;

  const dropDown(this.list);


  @override
  _dropDownState createState() => _dropDownState();

  String getAnswer()
  {
    return _dropDownState.getAnswer();
  }

}

class _dropDownState extends State<dropDown> {

  List<ReponseQuestion> reponse;
  ReponseQuestion selected = null;


  static String answer = '';

  @override
  Widget build(BuildContext context) {

    reponse = widget.list;

    return Container(

        padding:
        EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(10)),
        child: new Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white30,
          ),
          // dropdown below..
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              DropdownButton<ReponseQuestion>(
          items: reponse.map<DropdownMenuItem<ReponseQuestion>>((ReponseQuestion value) {
        return DropdownMenuItem<ReponseQuestion>(
        value: value,
        child: new SizedBox(
            width: 250.0,
            child: new Text(value.name),
        ),
        );
        }).toList(),

                  focusColor: Colors.white30,


                value: selected,


                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 42,
                  underline: SizedBox(),
                  onChanged: (ReponseQuestion newValue) {
                    setState(() {
                      selected = newValue;
                      answer = newValue.answer;


                    });
                  },

              )
            ],
          ),
        )
    );
  }

  static String getAnswer(){
    return answer;
  }

}
