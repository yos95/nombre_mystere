import 'package:flutter/material.dart';
import 'package:nombre_mystere/Database.dart';
import 'package:nombre_mystere/Jeux.dart';
import 'package:nombre_mystere/Score.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generat_nombre_mystere.dart';
import 'check.dart';
import 'Afficher_score.dart';
import 'dart:async';

void main() => runApp(new MyApp());
String nom_send;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Template',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Nombre mystére'),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new MyHomePage(),
        '/score': (BuildContext context) => new AfficherScore(),
        '/jeux': (BuildContext context) => new Jeux(nom_send),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Comment t'appele tu ?"),
          content: new TextField(
            autofocus: true,
            controller: myController,
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Valider"),
              onPressed: () {
                nom_send = myController.text;
                print(nom_send);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => Jeux(nom_send)));
              },
            ),
          ],
        );
      },
    );
  }

  // user defined function

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              child: const Text(' Jouer une partie'),
              color: Colors.white,
              elevation: 5.0,
              splashColor: Colors.blueGrey,
              onPressed: () {
                _showDialog();
                // Perform some action
              },
            ),
            new RaisedButton(
              child: const Text('Afficher les scores'),
              color: Colors.white,
              elevation: 4.0,
              splashColor: Colors.blueGrey,
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/score');
                // Perform some action
              },
            ),
          ],
        ),
      ),
    );
  }
}
