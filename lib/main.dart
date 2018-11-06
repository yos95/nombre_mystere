import 'package:flutter/material.dart';
import 'package:nombre_mystere/Database.dart';
import 'package:nombre_mystere/Score.dart';
import 'generat_nombre_mystere.dart';
import 'check.dart';
import 'Afficher_score.dart';



void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Template',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Template'),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new MyHomePage(),
        '/score': (BuildContext context) => new AfficherScore(),
        /* '/contact': (BuildContext context) => new ContactPage(), */
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
var nombre_mystere =  generat_nombre_mystere() ;
String result= '';
String nom;
class _MyHomePageState extends State<MyHomePage> {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextField(
              onSubmitted: (var string){
                    nom = string ;
              }
            ),
            new TextField(
              enabled: etat_partie,
              keyboardType: TextInputType.number,
            onSubmitted: (var string){
              nb_essais++;
             var saisie = int.parse(string);
            result = check_mystere(saisie, nombre_mystere);
        
            setState(() {
                          result = result;
                          if  (!etat_partie){
                             ScoreUser scoreUser = new ScoreUser(nom,nb_essais);
                         var dbHelper =  DBHelper();
                          dbHelper.initDb();

                         dbHelper.saveScore(scoreUser);
                        
                        
        //afficher la liste des score

                          }
                        });
            },
            decoration: new InputDecoration(
              labelText: 'Entrez un chiffre entre 0 et 100 $nombre_mystere'
            ),
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
)
          ],
        ),
      ),
    );
  }
}
