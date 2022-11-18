import 'package:dio/dio.dart';
import 'package:step_post_mobile_flutter/models/infos_courriers.dart';
import 'package:step_post_mobile_flutter/models/statut.dart';

class APIService {
  static final APIService _instance = APIService._internal();

  late String baseUrl;
  late Dio dio;
  String token = "";

  factory APIService() => _instance;

  APIService._internal() {
    baseUrl = "http://dev01.step.eco:3000/api";
    dio = Dio();
  }

  set isToken(String value) {
    token = value;
  }

  Future<Response> getData({required String path}) async {
    dio.options.headers['Authorization'] = "Bearer $token";
    final Response response = await dio.get(
      baseUrl + path,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw (response);
    }
  }

  Future<Response> putData(
      {required String path, required Map<String, dynamic> datas}) async {
    dio.options.headers['Authorization'] = "Bearer $token";
    final response = await dio.put(baseUrl + path, data: datas);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw (response);
    }
  }

  Future<bool> getTestToken({required String tokenToTest}) async {
    dio.options.headers['Authorization'] = "Bearer $tokenToTest";
    final response = await dio.get("$baseUrl/auth/handshake");
    if (response.statusCode == 200) {
      return response.data['result'];
    } else {
      throw (response);
    }
  }

  Future<Map<String, dynamic>> login(
      {required String username, required String password}) async {
    final response = await dio.post("$baseUrl/auth/facteur/login",
        data: {'username': username, 'password': password});
    if (response.statusCode == 200) {
      Map<String, dynamic> data = {
        "token": response.data['token'],
        "name": response.data['username'],
        "httpCode": response.statusCode
      };
      return data;
    } else {
      throw (response);
    }
  }

  Future<InfosCourrier> getCurrentScan({required String bordereau}) async {
    final response =
        await getData(path: "/facteur/courrier?bordereau=$bordereau");
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      return InfosCourrier.fromJson(data);
    } else {
      throw (response);
    }
  }

  Future<List<Statut>> getStatutsList() async {
    Response response = await getData(path: '/facteur/statuts');
    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      List<Statut> etats = data.map<Statut>((dynamic jsonStatut) {
        return Statut.fromJson(jsonStatut);
      }).toList();
      return etats;
    } else {
      throw (response);
    }
  }

  Future<String> getUpdatedStatut(
      {required String bordereau, required int state}) async {
    final response = await getData(
        path: "/facteur/update?bordereau=$bordereau&state=$state");
    if (response.statusCode == 201) {
      Map data = response.data;
      return (data['message']);
    } else {
      throw (response);
    }
  }

  Future<String> postSignature(
      {required int courrierId, required dynamic signature}) async {
    Map<String, dynamic> datas = {
      "courrierId": courrierId,
      "signature": signature
    };
    final response = await putData(path: '/facteur/signature', datas: datas);
    if (response.statusCode == 201) {
      return response.data['message'];
    } else {
      throw (response);
    }
  }
}
