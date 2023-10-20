class ViaCepList {
  List<ViaCepModel> ceps = [];

  ViaCepList(this.ceps);

  ViaCepList.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      ceps = <ViaCepModel>[];
      json['results'].forEach((v) {
        ceps.add(ViaCepModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = ceps.map((v) => v.toJson()).toList();
    return data;
  }
}

class ViaCepModel {
  String? objectId;
  String? cep;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? localidade;
  String? uf;
  String? ibge;
  String? gia;
  String? ddd;
  String? siafi;
  String? createdAt;
  String? updatedAt;

  ViaCepModel(
      {required this.cep,
      required this.logradouro,
      required this.complemento,
      required this.bairro,
      required this.localidade,
      required this.uf,
      required this.ibge,
      required this.gia,
      required this.ddd,
      required this.siafi});

  ViaCepModel.empty();

  ViaCepModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
    ibge = json['ibge'];
    gia = json['gia'];
    ddd = json['ddd'];
    siafi = json['siafi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['ibge'] = ibge;
    data['gia'] = gia;
    data['ddd'] = ddd;
    data['siafi'] = siafi;
    return data;
  }

  @override
  String toString() {
    return 'ObjectId: $objectId \nCep: $cep \nLogradouro: $logradouro \nComplemento: $complemento \nBairro: $bairro \nLocalidade: $localidade \nUF: $uf \nIBGE: $ibge \nGIA: $gia \nDDD: $ddd \nSiafi: $siafi';
  }
}
