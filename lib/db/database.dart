import 'dart:io';

import 'package:organizer/models/transaction.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;

  String transactionTable = 'Transactions';
  String columnId = 'id';
  String columnName = 'name';
  String columnDate = 'date';
  String columnSum = 'sum';

  Future<Database> get database async => _database ??= await _initDB();

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'Transactions.db';

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    await db.execute('CREATE TABLE $transactionTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName Text, $columnSum INTEGER, $columnDate INTEGER)');
  }

  Future<List<TransactionModel>> getTransactions(bool sum) async {
    try {
      Database db = await database;
      final List<Map<String, dynamic>> costMapList = await db.query(transactionTable);
      final List<TransactionModel> costList = [];

      costMapList.forEach((cost) {
        final costModel = TransactionModel.fromMap(cost);
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
    } catch(e) {
      return Future.value([]);
    }
  }

  Future<TransactionModel> insertTransaction(TransactionModel transaction) async {
    try {
      Database db = await database;
      transaction.id = await db.insert(transactionTable, transaction.toMap());

      return transaction;
    } catch(e) {
      return transaction;
    }
  }

  Future<int> updateTransaction(TransactionModel transaction) async {
    try {
      Database db = await database;
      return await db.update(
        transactionTable,
        transaction.toMap(),
        where: '$columnId = ?',
        whereArgs: [transaction.id]
      );
    } catch(e) {
      return -1;
    }
  }

  Future<int> deleteTransaction(int id) async {
    try {
      Database db = await database;
      return await db.delete(
        transactionTable,
        where: '$columnId = ?',
        whereArgs: [id]
      );
    } catch(e) {
      return -1;
    }
  }

  deleteAllTransaction() async {
    Database db = await database;
    await db.execute('DROP TABLE IF EXISTS $transactionTable');
  }
}