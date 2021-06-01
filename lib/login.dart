import 'package:dbfb/google_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dbfb/home.dart';
import 'package:dbfb/google_auth.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LogInScreen createState() => _LogInScreen();
}

class _LogInScreen extends State<LogInScreen> {

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  Text infologin = Text('');
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
            ElevatedButton(onPressed: () async {
              try {
                UserCredential uc = await _auth.signInWithEmailAndPassword(
                    email: _email.text, password: _password.text);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Home()));
              } on FirebaseAuthException catch(e) {
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                  setState(() {
                    infologin = Text('Usuário não existe.');
                  });
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                  setState(() {
                    infologin = Text('Senha incorreta.');
                    
                  });
                }
              }
            },
                child: Text('Send')),
            ElevatedButton(onPressed: () async {
              try {
                await _auth.createUserWithEmailAndPassword(
                  email: _email.text, password: _password.text);
              } on FirebaseAuthException catch(e) {
                setState(() {
                   infologin = Text('Impossível criar usuário.');
                   

                });
              }
              setState(() {
                _email.text = '';
                _password.text = '';
              });
            },
                child: Text('Create')),
            infologin,
            ElevatedButton(onPressed: () async {
              try {
                MyGoogleAuth.signInWithGoogle(context);
              } on Exception catch(e) {
                print('Erro de conexão.');
                ScaffoldMessenger.of(context).showSnackBar(
                    MyGoogleAuth.customSnackBar('Erro de conexão.')
                );

              }
            }, child:
              Text('Google')),
            
          ],
        ),
      ),
    );
  }
}
