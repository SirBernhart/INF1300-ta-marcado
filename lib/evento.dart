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
}
