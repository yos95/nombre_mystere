import 'package:flutter/material.dart';
import 'package:nombre_mystere/Database.dart';
import 'package:nombre_mystere/Score.dart';

Future<List<ScoreUser>> fetchScoreUsersromDatabase() async {
  var dbHelper = DBHelper();
  Future<List<ScoreUser>> score = dbHelper.getScores();
  return score;
}

class AfficherScore extends StatefulWidget {
  final String title = 'Score';

  @override
  _AfficherScore createState() => new _AfficherScore();
}

class _AfficherScore extends State<AfficherScore> {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Container(
        padding: new EdgeInsets.all(16.0),
        child: new FutureBuilder<List<ScoreUser>>(
          future: fetchScoreUsersromDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(snapshot.data[index].nom,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text(snapshot.data[index].score.toString(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                          new Divider()
                        ]);
                  });
            } else if (snapshot.data.length == 0) {
              return new Text("No Data found");
            }
            return new Container(
              alignment: AlignmentDirectional.center,
              child: new CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: floatingAppuyer,
        child: new Icon(Icons.delete),
      ),
    );
  }
}

void floatingAppuyer() {
  var dbHelper = DBHelper();

  dbHelper.initDb;
  dbHelper.DeleteAll();
}
