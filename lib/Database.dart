import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'Score.dart';

class DBHelper{

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  //Creating a database with name Database.dn in your directory
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Database.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  // Creating a table name Score with fields
  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
    "CREATE TABLE Score(id INTEGER PRIMARY KEY, nom TEXT, score INTEGER)");
    print("Created tables");
  }
  
  // Retrieving Scores from Score Tables
  Future<List<ScoreUser>> getScores() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Score');
    List<ScoreUser> Scores = new List();
    for (int i = 0; i < list.length; i++) {
      Scores.add(new ScoreUser(list[i]["nom"], list[i]["score"]));
    }
    print(Scores.length);
    return Scores;
  }
  
  void saveScore(ScoreUser Score) async {
    var dbClient = await db;
   

    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO Score(nom, score ) VALUES(\'${Score.nom}\', \'${Score.score}\')'
          
          );
  });
    
          print('insert effectuer');

  }
    }
