import 'package:flutter/material.dart';
import 'package:mdefi/models/user.dart';
import 'package:mdefi/screens/wrapper.dart';
import 'package:mdefi/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //we return the wrapper
        home: Wrapper(),
      ),
    );

  }
}


