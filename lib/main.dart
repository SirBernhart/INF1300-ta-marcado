import 'package:flutter/material.dart';
import 'package:ta_marcado/evento.dart';
import 'package:ta_marcado/evento_api.dart';
import 'package:ta_marcado/detalhesEvento.dart';
import 'package:swipedetector/swipedetector.dart';
import 'createEventPage.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'evento.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    EventoWidget eventos = new EventoWidget();

    return MaterialApp(
        title: 'Flutter',
        home: Scaffold(
          backgroundColor: Colors.blueGrey,
          appBar: AppBar(
              actions: <Widget>[
                Builder(
                  builder: (context) => IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        navigateToSubPage(context);
                      }),
                )
              ],
              title: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Tá Marcado'),
                ],
              ))),
          body: eventos,
        ),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ));
  }
}

Future navigateToSubPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => CreateEventPage()));
}

class EventoWidget extends StatefulWidget {
  EventoWidget({Key keyteste}) : super(key: keyteste);

  @override
  _EventoWidgetState createState() => _EventoWidgetState();
}

class _EventoWidgetState extends State<EventoWidget> {
  EventoApi _api = new EventoApi();
  List<Evento> _listaeventos;

  @override
  void initState() {
    super.initState();
    getEventos();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _listaeventos == null
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: _listaeventos.length,
              itemBuilder: (BuildContext context, int index) {
                Evento evento = _listaeventos[index];

                // return SwipeDetector(
                //   onSwipeLeft: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (BuildContext context) =>
                //             new DetalhesEvento(evento)));
                //   }
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new DetalhesEvento(evento)));
                  },
                  child: Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    borderOnForeground: true,
                    color: Colors.grey[100],
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
                            child: CircleAvatar(
                                radius: 52,
                                backgroundColor: Colors.black54,
                                child: ((() {
                                  if ("${evento.descricao}" == "Festa") {
                                    return CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.blue,
                                      backgroundImage: AssetImage(
                                          'images/party-popper-icon.png'),
                                    );
                                  } else if ("${evento.descricao}" ==
                                      "Evento musical") {
                                    return CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.blue,
                                      backgroundImage:
                                          AssetImage('images/music-icon.png'),
                                    );
                                  } else if ("${evento.descricao}" == "Show") {
                                    return CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.blue,
                                      backgroundImage:
                                          AssetImage('images/concert-icon.png'),
                                    );
                                  }
                                  return CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.blue,
                                    backgroundImage:
                                        AssetImage('images/gathering-icon.png'),
                                  );
                                })()))),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(bottom: 40.0, left: 15.0),
                              child: Text("${evento.descricao} ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 40.0),
                              child: Text(
                                "${evento.nome}" + " - " + "${evento.local}",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }

  void getEventos() async {
    _listaeventos = await _api.getEventos();
    setState(() {});
  }
}
