import 'dart:io';

import 'package:organizer/models/cost.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;

  String costTable = 'Const';
  String columnId = 'id';
  String columnName = 'name';
  String columnDate = 'date';
  String columnSum = 'sum';

  Future<Database> get database async => _database ??= await _initDB();

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'Cost.db';

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    await db.execute('CREATE TABLE $costTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName Text, $columnSum INTEGER, $columnDate DATETIME)');
  }

  Future<List<Cost>> getCosts(bool sum) async {
    Database db = await this.database;
    final List<Map<String, dynamic>> costMapList = await db.query(costTable);
    final List<Cost> costList = [];

    costMapList.forEach((cost) {
      final costModel = Cost.fromMap(cost);
      if (sum == true) {
        try {
          final savedModel = costList.firstWhere((element) => element.name == costModel.name);
          savedModel.sum += costModel.sum;
        } catch(e) {
          costList.add(costModel);
        }
      } else {
        costList.add(costModel);
      }
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