import 'package:dio/dio.dart';
import 'package:viacep/models/via_cep_model.dart';

abstract class ViaCepRepository {
  static Future<ViaCepModel> consultarCEP(String cep) async {
    Response response = await Dio().get("https://viacep.com.br/ws/$cep/json/");
    if (response.statusCode == 200) {
      return ViaCepModel.fromJson(response.data);
    }
    return ViaCepModel.empty();
  }
}
