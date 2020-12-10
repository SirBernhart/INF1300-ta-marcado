import 'package:ta_marcado/evento_api.dart';
import 'evento.dart';
import 'databaseManager.dart';
import 'package:flutter/material.dart';
import 'package:ta_marcado/databaseManager.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  int _id;
  String _name;
  String _description;
  String _local;
  DateTime _date;
  String _address;

  TextEditingController nameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
              ),
              Text('Voltar',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
            ],
          )),
    );
  }

  Function updateName(String newName) {
    _name = newName;
  }

  Widget _singleLineInputField(String title, int maxLenght) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
              controller: nameController,
              onChanged: (name) => _name = nameController.text,
              maxLength: maxLenght,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.blueGrey,
                  filled: true))
        ],
      ),
    );
  }

  Widget _singleLineInputFieldAddress(String title, int maxLenght) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
              controller: addressController,
              onChanged: (address) => _address = addressController.text,
              maxLength: maxLenght,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.blueGrey,
                  filled: true))
        ],
      ),
    );
  }

  Widget _multiLineInputField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
              controller: descriptionController,
              onChanged: (description) =>
                  _description = descriptionController.text,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.blueGrey,
                  filled: true))
        ],
      ),
    );
  }

  Widget _datePicker() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Escolha uma data",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),
          RaisedButton(
            child: Text('Escolha uma data'),
            onPressed: () {
              showDatePicker(
                      context: context,
                      initialDate: _date == null ? DateTime.now() : _date,
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2021))
                  .then((date) {
                setState(() {
                  _date = date;
                });
              });
            },
          )
        ],
      ),
    );
  }

  getNextEventId() async {
    List<Evento> eventos = await new EventoApi().getEventos();

    int largestId = -1;
    for (int i = 0; i < eventos.length; ++i) {
      if (eventos[i].id > largestId) largestId = eventos[i].id;
    }
    return largestId + 1;
  }

  void criarNovoEvento() async {
    _id = await getNextEventId();
    final Evento novoEvento = Evento(
      id: _id,
      nome: _name,
      descricao: _description,
      local: _address,
      data: _date.toIso8601String(),
    );

    new EventoApi().inserirEvento(novoEvento);
  }

  Widget _submitButton() {
    return GestureDetector(
        onTap: () {
          criarNovoEvento();
          Navigator.pop(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)])),
          child: Text(
            'Criar evento',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _singleLineInputField('Nome do evento', 40),
                        _multiLineInputField('Descrição'),
                        _singleLineInputFieldAddress('Endereço do evento', 80),
                        _datePicker(),
                        _submitButton(),
                      ],
                    ),
                  )),
              Positioned(top: 30, left: 0, child: _backButton()),
            ],
          ),
        ),
      ),
    );
  }
}
