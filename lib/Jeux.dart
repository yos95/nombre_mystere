import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nombre_mystere/Database.dart';
import 'package:nombre_mystere/Score.dart';
import 'generat_nombre_mystere.dart';
import 'check.dart';

var dbHelper = DBHelper();
String nom;
var nombre_mystere = generat_nombre_mystere();
String result = '';

class Jeux extends StatefulWidget {
  final String title = 'Jeux';
  Jeux(String myparam) {
    nom = myparam;
    print(nom);
  }

  _Jeux createState() => new _Jeux();
}

@override
class _Jeux extends State<Jeux> {
  TextEditingController _controller = new TextEditingController();
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
            /* new Text('Hello'),
            new IconButton(
              icon: Icon(Icons.account_circle),
              tooltip: 'Increase volume by 10%',
              onPressed: () {},
            ), */
            new RichText(
              text: TextSpan(
                  text: 'C\'est partie ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30.0)),
            ),
            new Container(
              margin: new EdgeInsets.all(25.0),
              child: new TextField(
                controller: _controller,
                autofocus: true,
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(2),
                ],
                enabled: etat_partie,
                keyboardType: TextInputType.number,
                onSubmitted: (var string) {
                  nb_essais++;
                  var saisie = int.parse(string);
                  result = check_mystere(saisie, nombre_mystere);

                  setState(() {
                    result = result;
                    _controller.clear();
                    if (!etat_partie) {
                      print(etat_partie);
                      ScoreUser scoreUser = new ScoreUser(nom, nb_essais);
                      dbHelper.initDb();

                      dbHelper.saveScore(scoreUser);

                      //afficher la liste des score

                    }
                  });
                },
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(20.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey[800]),
                    hintText: "Entrez un chiffre",
                    fillColor: Colors.white,
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            new Text(
              '$result',
            ),
            IconButton(
              icon: Icon(Icons.arrow_right),
              tooltip: 'Increase volume by 10%',
              onPressed: () {
                Navigator.of(context).pushNamed('/score');
              },
            ),
          ],
        ),
      ),
    );
  }
}
