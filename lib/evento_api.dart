import 'dart:convert';
import 'package:ta_marcado/databaseManager.dart';
import 'package:ta_marcado/evento.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class EventoApi {
  Future<dynamic> _get() async {
    return jsonDecode(jsonString);
  }

  Future<void> inserirEvento(Evento evento) async {
    final Database db = await new DatabaseManager().initDatabase();

    await db.insert(
      'eventos',
      evento.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    printEventos();
  }

  Future<List<Evento>> loadJsonFromApi() async {
    List<dynamic> responseJson = await _get();
    List<Evento> eventos = new List();
    responseJson
        .forEach((cadaEvento) => eventos.add(Evento.fromJson(cadaEvento)));
    return eventos;
  }
  /*final testeEvento = Evento(
      id: 0,
      nome: 'Testevento',
      descricao: 'Testetestestes',
      local: 'testelocal',
      data: '9999-12-30 10:00:00.999');

  await inserirEvento(testeEvento);*/

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

  String jsonString = "[" +
      "{" +
      "\"descricao\":\"Evento musical\"," +
      "\"nome\":\"Barzinho\"," +
      "\"local\":\"Leblon\"" +
      "}," +
      "{" +
      "\"descricao\":\"Festa\"," +
      "\"nome\":\"Kriok\"," +
      "\"local\":\"Ipanema\"" +
      "}," +
      "{" +
      "\"descricao\":\"Show\"," +
      "\"nome\":\"RiR\"," +
      "\"local\":\"Recreio\"" +
      "}," +
      "{" +
      "\"descricao\":\"Encontro\"," +
      "\"nome\":\"Fã clube\"," +
      "\"local\":\"Botafogo\"" +
      "}]";

  void printEventos() async {
    List<Evento> listEventos = await getEventos();
    for (int i = 0; i < listEventos.length; i++) {
      print(listEventos[i].nome);
    }
  }
}
