import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ta_marcado/eventos.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';

class HomePage extends StatefulWidget {
  final markerLocation;

  const HomePage({Key key, this.markerLocation}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.markerLocation ?? LatLng(14, 20),
        zoom: 15,
      ),
      myLocationEnabled: true,
      markers: widget.markerLocation != null
          ? [
              Marker(
                  markerId: MarkerId("Tap Location"),
                  position: widget.markerLocation),
            ].toSet()
          : null,
    );
  }
}

class DetalhesEvento extends StatefulWidget {
  final Eventos _listaeventos;
  DetalhesEvento(this._listaeventos);

  @override
  _DetalhesEventoState createState() => _DetalhesEventoState();
}

class _DetalhesEventoState extends State<DetalhesEvento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhes")),
      body: buildDetails(),
    );
  }

  Widget buildDetails() {
    return Container(
        color: Colors.blueGrey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
                    child: ((() {
                      if ("${widget._listaeventos.descricao}" == "Festa") {
                        return CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.blueAccent,
                          backgroundImage:
                              AssetImage('images/party-popper-icon.png'),
                        );
                      } else if ("${widget._listaeventos.descricao}" ==
                          "Evento musical") {
                        return CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.blueAccent,
                          backgroundImage: AssetImage('images/music-icon.png'),
                        );
                      } else if ("${widget._listaeventos.descricao}" ==
                          "Show") {
                        return CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.blueAccent,
                          backgroundImage:
                              AssetImage('images/concert-icon.png'),
                        );
                      }
                      return CircleAvatar(
                        radius: 40.0,
                        backgroundColor: Colors.blueAccent,
                        backgroundImage:
                            AssetImage('images/gathering-icon.png'),
                      );
                    })())),
                Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "${widget._listaeventos.descricao}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0),
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Nome:" + " ${widget._listaeventos.nome}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Local:" + " ${widget._listaeventos.local}",
                      style: TextStyle(
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 407,
                  // height: MediaQuery.of(context).size.height,
                  child: ((() {
                    if ("${widget._listaeventos.local}" == "Leblon") {
                      return HomePage(
                        markerLocation: const LatLng(-22.984052, -43.223129),
                      );
                    } else if ("${widget._listaeventos.local}" == "Ipanema") {
                      return HomePage(
                        markerLocation: const LatLng(-22.984641, -43.198566),
                      );
                    } else if ("${widget._listaeventos.local}" == "Botafogo") {
                      return HomePage(
                        markerLocation: const LatLng(-22.950951, -43.180969),
                      );
                    }
                    return HomePage(
                      markerLocation: const LatLng(-22.980473, -43.406923),
                    );
                  })()),
                ),
              ],
            ),
          ],
        ));
  }
}
