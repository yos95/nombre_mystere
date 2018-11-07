import 'package:flutter/material.dart';
import 'package:nombre_mystere/Database.dart';
import 'package:nombre_mystere/Score.dart';
import 'generat_nombre_mystere.dart';
import 'check.dart';
import 'package:shared_preferences/shared_preferences.dart';

var dbHelper = DBHelper();
var nombre_mystere = generat_nombre_mystere();
String result = '';
_loadName() async {
  final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it does not exist, return 0.
  String nom = prefs.getString('nom') ?? 0;
  print(nom);
}

class Jeux extends StatefulWidget {
  final String title = 'Jeux';

  @override
  _Jeux createState() => new _Jeux();
}

class _Jeux extends State<Jeux> {
  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Hello'),
            new IconButton(
              icon: Icon(Icons.account_circle),
              tooltip: 'Increase volume by 10%',
              onPressed: () {},
            ),
            new TextField(
              enabled: etat_partie,
              keyboardType: TextInputType.number,
              onSubmitted: (var string) {
                nb_essais++;
                var saisie = int.parse(string);
                result = check_mystere(saisie, nombre_mystere);

                setState(() {
                  result = result;
                  if (!etat_partie) {
                    String a;
                    ScoreUser scoreUser = new ScoreUser(a, nb_essais);
                    dbHelper.initDb();

                    dbHelper.saveScore(scoreUser);

                    //afficher la liste des score

                  }
                });
              },
              decoration: new InputDecoration(
                  labelText:
                      'Entrez un chiffre entre 0 et 100 $nombre_mystere'),
            ),
            new Text(
              '$result',
            ),
            IconButton(
              icon: Icon(Icons.arrow_right),
              tooltip: 'Increase volume by 10%',
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/score');
              },
            ),
          ],
        ),
      ),
    );
  }
}
