import 'package:camera/models/DBHelper.dart';
import 'package:camera/models/DBheelper.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import '../models/places.dart';
import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart' as sql;

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
 
  List<Place> get items {
    return [..._items];
  }




  //  static Future<void> init() async {


  //    print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
  //   if (_db != null) {
  //     return;
  //   }

  //   try {
  //     var databasesPath = await getDatabasesPath();
  //     String _path = p.join(databasesPath, 'crud.db');
  //     _db = await openDatabase(_path, version: 1, onCreate: onCreate);
  //   } catch (ex) {
  //     print(ex);
  //   }
  // }

  // static void onCreate(Database db, int version) async {
  //   await db.execute(
  //       'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      
  // }
  // 

  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  void addPlace( File image,String title )async{
       
       var newplace =Place(id: DateTime.now().toString(), title: title, location: null, image: image);

       _items.add(newplace);
        notifyListeners();
        final db = await database();
        print(db);
        db.insert('user_places', {
         'id':newplace.id,
         'title':newplace.title,
         'image':newplace.image.path
       },   conflictAlgorithm: ConflictAlgorithm.replace,);

  

  }




  
   Future<void> fetchAndSetPlaces() async {
    
    final db = await database();
     print(db);
    final dataList = await db.query('user_places');
    _items = dataList
        .map(
          (item) => Place(
                id: item['id'],
                title: item['title'],
                image: File(item['image']),
                location: null,
              ),
        )
        .toList();
    notifyListeners();
  }


  

}
