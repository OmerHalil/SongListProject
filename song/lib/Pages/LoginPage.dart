
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Song List e hoş geldiniz"),


        FlatButton(
          child: Text("Devam et>"),
          onPressed: () {

        },)


      ],

    );
  }
}
