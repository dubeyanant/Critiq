import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:critiq/models/item.dart';

class DBHelper {
  static const _databaseName = 'item.db';
  static const _itemTable = 'item_table';
  static const _databaseVersion = 1;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    // lazily instantiate the db the first time it is accessed
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    String path = join(await getDatabasesPath(), _databaseName);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $_itemTable('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, characterRating STRING, endingRating STRING, initialResponseRating STRING, plotRating STRING, recommendationRating STRING, rewatchabilityRating STRING, rating STRING, type STRING'
        ')');
  }

  Future<int> insertItem(Item item) async {
    Database? db = DBHelper._database;
    return await db!.insert(_itemTable, {
      'title': item.title,
      'characterRating': item.characterRating,
      'endingRating': item.endingRating,
      'initialResponseRating': item.initialResponseRating,
      'plotRating': item.plotRating,
      'recommendationRating': item.recommendationRating,
      'rewatchabilityRating': item.rewatchabilityRating,
      'rating': item.rating,
      'type': item.type.toString(),
    });
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = DBHelper._database;
    return await db!.query(_itemTable);
  }

  Future<int> delete(int id) async {
    Database? db = DBHelper._database;
    return await db!.delete(_itemTable, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCategory(String type) async {
    Database? db = DBHelper._database;
    return await db!.delete(_itemTable, where: 'type = ?', whereArgs: [type]);
  }

  Future<int> deleteAllItem() async {
    Database? db = DBHelper._database;
    return await db!.delete(_itemTable);
  }
}
