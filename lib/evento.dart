class Evento {
  int id;
  String nome;
  String descricao;
  String local;
  String data;

  Evento({this.id, this.nome, this.descricao, this.local, this.data});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'local': local,
      'data': data,
    };
  }

  factory Evento.fromJson(Map<String, dynamic> json) {
    return new Evento(
        id: json['id'] as int,
        nome: json['nome'] as String,
        descricao: json['descricao'] as String,
        local: json['local'] as String,
        data: json['data'] as String);
  }
}
