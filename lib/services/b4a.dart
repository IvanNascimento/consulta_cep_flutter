import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:viacep/models/via_cep_model.dart';
import 'package:viacep/services/interseptor.dart';

class B4aRepository {
  final Dio _dio = Dio();

  B4aRepository() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = "${dotenv.get("BACK4APPBASEURL")}/ViaCep";
    _dio.interceptors.add(B4aInterceptor());
  }

  Future<ViaCepList> getCEPs() async {
    Response res = await _dio.get('/');
    return ViaCepList.fromJson(res.data);
  }

  Future<void> criar(ViaCepModel viaCep) async {
    try {
      Response res = await _dio.post("/", data: viaCep.toJson());
      debugPrint(res.data.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizar(ViaCepModel viaCep) async {
    try {
      Response res =
          await _dio.put("/${viaCep.objectId}", data: viaCep.toJson());
      debugPrint(res.data.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      Response res = await _dio.delete(
        "/$objectId",
      );
      debugPrint(res.data.toString());
    } catch (e) {
      rethrow;
    }
  }
}
