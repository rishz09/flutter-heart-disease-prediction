//ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'detail.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper =
      DatabaseHelper._createInstance();

  DatabaseHelper._createInstance();

  static late Database _database;

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  Future<Database> get database async {
    _database = await initializeDatabase();
    return _database;
  }

  String detailsTable = 'details_table_new',
      colId = 'id',
      age = 'age',
      sex = 'sex',
      chestPainType = 'chestPainType',
      fastingBS = 'fastingBS',
      fastingBSTemp = 'fastingBSTemp',
      restingECG = 'restingECG',
      exerciseAngina = 'exerciseAngina',
      stSlope = 'stSlope',
      restingBP = 'restingBP',
      cholesterol = 'cholesterol',
      maxHR = 'maxHR',
      oldpeak = 'oldpeak',
      pred = 'pred',
      date = 'date',
      title = 'title';

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}details_new.db';

    var detailsDatabase =
        openDatabase(path, version: 1, onCreate: ((db, version) async {
      await db.execute('CREATE TABLE $detailsTable('
          '$colId INTEGER PRIMARY KEY AUTOINCREMENT, '
          '$date TEXT, '
          '$title TEXT, '
          '$age INTEGER, '
          '$sex INTEGER, '
          '$chestPainType INTEGER, '
          '$fastingBS INTEGER, '
          '$fastingBSTemp REAL, '
          '$restingECG INTEGER, '
          '$exerciseAngina INTEGER, '
          '$stSlope INTEGER, '
          '$restingBP REAL, '
          '$cholesterol REAL, '
          '$maxHR REAL, '
          '$oldpeak REAL, '
          '$pred REAL)');
    }));
    return detailsDatabase;
  }

  Future<List<Map<String, dynamic>>> getDetailMapList() async {
    Database db = await this.database;
    //have a look at how to sort
    var result = await db.query(detailsTable);
    return result;
  }

  Future<int> insertDetail(Detail detail) async {
    Database db = await this.database;

    //returns primary key of an inserted row, or -1 if an error has occurred
    int result = await db.insert(detailsTable, detail.toMap());
    return result;
  }

  Future<int> updateDetail(Detail detail) async {
    Database db = await this.database;

    int result = await db.update(detailsTable, detail.toMap(),
        where: '$colId = ?', whereArgs: [detail.id]);
    return result;
  }

  Future<int> deleteDetail(int id) async {
    Database db = await this.database;

    int result =
        await db.rawDelete('DELETE FROM $detailsTable where $colId = $id');

    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $detailsTable');

    //return Sqflite.firstIntValue(x) if it is not null, else 0
    int result = Sqflite.firstIntValue(x) ?? 0;
    return result;
  }

  Future<List<Detail>> getDetailList() async {
    var detailMapList = await getDetailMapList();
    int count = detailMapList.length;

    List<Detail> detailList = [];
    for (int i = 0; i < count; i++) {
      detailList.add(Detail.fromMapObject(detailMapList[i]));
    }

    return detailList;
  }
}
