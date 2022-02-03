import 'dart:io';

import 'package:organizer/models/cost.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  String costTable = 'Const';
  String columnId = 'id';
  String columnName = 'name';
  String columnDate = 'date';
  String columnSum = 'sum';

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDB();

    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'Const.db';

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    await db.execute('CREATE TABLE $costTable($columnId INTEGER PRIMARY KEY AUTOINCCREMENT, $columnName Text, $columnSum INTEGER, $columnDate DATETIME)');
  }

  Future<List<Cost>> getCosts() async {
    Database db = await this.database;
    final List<Map<String, dynamic>> costMapList = await db.query(costTable);
    final List<Cost> costList = [];

    costMapList.forEach((cost) {
      costList.add(Cost.fromMap(cost));
    });

    return costList;
  }

  Future<Cost> insertCost(Cost cost) async {
    Database db = await this.database;
    cost.id = await db.insert(costTable, cost.toMap());

    return cost;
  }

  Future<int> updateCost(Cost cost) async {
    Database db = await this.database;
    return await db.update(
      costTable,
      cost.toMap(),
      where: '$columnId = ?',
      whereArgs: [cost.id]
    );
  }

  Future<int> deleteCost(int id) async {
    Database db = await this.database;
    return await db.delete(
      costTable,
      where: '$columnId = ?',
      whereArgs: [id]
    );
  }
}