import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  DatabaseManager() {
    initDatabase();
  }

  Future<Database> initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();

    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'databaseTaMarcado.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE eventos(id INTEGER PRIMARY KEY, nome TEXT, descricao TEXT, local TEXT, data INTEGER)",
        );
      },
      version: 1,
    );
    return database;
  }
}
