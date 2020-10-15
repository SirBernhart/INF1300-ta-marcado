import 'package:ta_marcado/eventos.dart';
import 'dart:convert';

class EventoApi {
  Future<dynamic> _get() async {
    return jsonDecode(jsonString);
  }

  Future<List<Eventos>> loadJsonFromApi() async {
    List<dynamic> responseJson = await _get();
    List<Eventos> eventos = new List();
    responseJson
        .forEach((cadaEvento) => eventos.add(Eventos.fromJson(cadaEvento)));
    return eventos;
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
}
