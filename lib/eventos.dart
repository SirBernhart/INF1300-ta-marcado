class Eventos {
  String nome;
  String descricao;
  String local;
  DateTime data;

  // json -> object
  Eventos.fromJson(Map<String, dynamic> json)
      : nome = json['nome'],
        descricao = json['descricao'],
        local = json['local'];

  // object -> json
  Map<String, dynamic> toJson() =>
      {'nome': nome, 'descricao': descricao, 'local': local};

  @override
  String toString() {
    return 'Eventos{nome: $nome, descricao: $descricao, local: $local}';
  }
}
