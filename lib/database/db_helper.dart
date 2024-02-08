import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:critiq/models/item.dart';

class DBHelper {
  static const _databaseName = 'items.db';
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
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $_itemTable('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, characterRating STRING, endingRating STRING, initialResponseRating STRING, plotRating STRING, recommendationRating STRING, rewatchabilityRating STRING, rating STRING, type STRING, isFavourite STRING'
        ')');
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // await db.execute('ALTER TABLE $_itemTable ADD COLUMN isFavourite STRING');
    }
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
      'isFavourite': item.isFavourite.toString(),
    });
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = DBHelper._database;
    return await db!.query(_itemTable);
  }

  Future<int> updateFavourites(int id, String isFavourite) async {
    return await _database!.update(
      _itemTable,
      {'isFavourite': isFavourite},
      where: 'id = ?',
      whereArgs: [id],
    );
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

  Future<void> dropTableAndDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    Database? db = await openDatabase(path, version: _databaseVersion);
    await db.close();
    await deleteDatabase(path);
  }
}
