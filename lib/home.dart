import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  final fbinstance = FirebaseFirestore.instance;
  String texto_lido = '';
  String s = '';
  TextEditingController tc1 = TextEditingController();
  TextEditingController tc2 = TextEditingController();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(controller: tc1),
            TextField(controller: tc2),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(onPressed: () {
              fbinstance.collection("info").add(
                  {
                    'nome' : tc1.text,
                    'contador' : _counter,
                    'valor' : double.parse(tc2.text)
                  }
              );
              setState(() {
                tc1.text = '';
                tc2.text = '';
                _counter = 0;
              });
            },
                child: Text('Send')),
            ElevatedButton(onPressed: () {
              s = '';
              fbinstance.collection("info").get().then((qs) {
                var elements = qs.docs;
                var n = qs.docs.length;
                var d1 = elements[n-1].data();
                s = d1['nome'].toString()+' '+d1['contador'].toString()+' '+d1['valor'].toString();
                setState(() {
                  texto_lido = s;
                });
              });


            },
                child: Text('Read')),
            Text(texto_lido),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
