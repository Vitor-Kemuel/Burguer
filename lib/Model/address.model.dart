class AddressModel {
  String? bairro;
  String? cep;
  String? cidade;
  String? complemento;
  String? logradouro;
  String? nome;
  String? numero;
  String? uid;

  AddressModel({
    required this.bairro,
    required this.cep,
    required this.cidade,
    required this.complemento,
    required this.logradouro,
    required this.nome,
    required this.numero,
    required this.uid,
  });

  AddressModel.fromJson(Map<String, dynamic> map) {
    bairro = map['bairro'];
    cep = map['cep'];
    cidade = map['cidade'];
    complemento = map['complemento'];
    logradouro = map['logradouro'];
    nome = map["nome"];
    numero = map['numero'];
    uid = map['uid'];
  }

    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["bairro"] = bairro;
    data["cep"] = cep;
    data["cidade"] = cidade;
    data["complemento"] = complemento;
    data["logradouro"] = logradouro;
    data["nome"] = nome;
    data["numero"] = numero;
    data["uid"] = uid;
    return data;
  }
}