import 'package:flutter/material.dart';
import 'package:mdefi/screens/DrawerScreens/profil.dart';
import 'package:mdefi/services/auth.dart';

class MainDrawer extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.blueGrey[400],
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 30,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://www.pngmart.com/files/4/Monsters-University-PNG-Transparent-Image.png'
                        ),
                        fit: BoxFit.fill
                      )
                    ),
                  ),

              Text(
              'loris.clivaz@students.hevs.ch',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
              ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Mon profil',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.android),
            title: Text(
              'About',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: null,


          )
        ],
      ),
    );
  }

  String getEmail()
  {
    dynamic result =  _auth.getCurrentEmail();

    return result;
  }
}
