import 'dart:convert';
import 'package:ta_marcado/databaseManager.dart';
import 'package:ta_marcado/evento.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class EventoApi {
  Future<void> inserirEvento(Evento evento) async {
    final Database db = await new DatabaseManager().initDatabase();

    await db.insert(
      'eventos',
      evento.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    printEventos();
  }

  Future<List<Evento>> getEventos() async {
    final Database db = await new DatabaseManager().initDatabase();

    final List<Map<String, dynamic>> maps = await db.query('eventos');

    return List.generate(maps.length, (i) {
      return Evento(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        descricao: maps[i]['descricao'],
        local: maps[i]['local'],
        data: maps[i]['data'],
      );
    });
  }

  void printEventos() async {
    List<Evento> listEventos = await getEventos();
    for (int i = 0; i < listEventos.length; i++) {
      print(listEventos[i].id.toString());
      print(listEventos[i].nome);
      print(listEventos[i].descricao);
      print(listEventos[i].local);
      print(listEventos[i].data);
    }
  }
}
