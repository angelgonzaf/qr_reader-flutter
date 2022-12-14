import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

import '../models/models.dart';

class DBProvider {
  
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }


  Future<Database> initDB() async {

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    //crear DB
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version ) async {

        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          );
        ''');
      }
    );
  }

  Future<int> nuevoScanRaw( ScanModel nuevoScan ) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    //verificar BBDD
    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans( id, tipo, valor)
        VALUES($id, $tipo, $valor)
      ''');

    return res;
  }


  Future<int> nuevoScan( ScanModel nuevoScan ) async {

    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    print(res);


    //el ID del ultimo registro insertado
    return res;

  }

  Future<ScanModel?> getScanById( int id ) async {
    
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty 
          ? ScanModel.fromJson(res.first)
          : null;

  }

  Future<List<ScanModel>> getScans() async {
    
    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty 
          ? res.map((e) => ScanModel.fromJson(e)).toList()
          : [];
  }


  Future<List<ScanModel>> getScansByTipo(String tipo) async {
    
    final db = await database;
    // final res = await db.rawQuery('''
    // SELECT * FROM Scans WHERE tipo == $tipo
    // ''');
    final res = await db.query('Scans', where: 'tipo = ?', whereArgs: [tipo]);

    return res.isNotEmpty 
          ? res.map((e) => ScanModel.fromJson(e)).toList()
          : [];
  }

  Future<int> updateScan(ScanModel scan) async {

    final db = await database;
    final res = await db.update('Scans', scan.toJson(), where: 'id = ?', whereArgs: [scan.id]);
    return res;
  }

  Future<int> deleteScan( int id) async {

    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteScans() async {

    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');
    return res;
  }

}