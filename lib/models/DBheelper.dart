import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';


abstract class DB {
  static Database _db;

  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) {
      return;
    }

    try {
      var databasesPath = await getDatabasesPath();
      String _path = p.join(databasesPath, 'crud.db');
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      
  }
    
   static Future<void> insert(String table, Map<String, Object> data) async {
 
    _db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }  

 static Future<List<Map<String, dynamic>>> getData(String table) async {
 
    return _db.query(table);
  }
}
