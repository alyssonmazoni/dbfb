import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dbfb/home.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LogInScreen createState() => _LogInScreen();
}

class _LogInScreen extends State<LogInScreen> {

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(controller: _email),
            TextField(controller: _password),
            ElevatedButton(onPressed: () {
              _auth.signInWithEmailAndPassword(email: _email.text, password: _password.text);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
            },
                child: Text('Send')),
          ],
        ),
      ),
    );
  }
}
