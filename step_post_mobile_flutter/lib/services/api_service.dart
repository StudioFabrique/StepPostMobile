import 'package:dio/dio.dart';
import 'package:step_post_mobile_flutter/models/courrier.dart';
import 'package:step_post_mobile_flutter/models/infos_courriers.dart';
import 'package:step_post_mobile_flutter/models/scan.dart';
import 'package:step_post_mobile_flutter/models/statut.dart';
import 'package:step_post_mobile_flutter/services/shared_handler.dart';
import 'package:step_post_mobile_flutter/utils/api.dart';

class APIService {
  static final APIService _instance = APIService._internal();

  late String baseUrl;
  late Dio dio;
  String token = "";

  factory APIService() => _instance;

  APIService._internal() {
    baseUrl = API().url;
    dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(InterceptorsWrapper(
      onError: (e, handler) {
        return handler.next(e);
      },
    ));
  }

  setToken(String value) {
    token = value;
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<Response> getData({required String path}) async {
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
    final response = await dio.put(baseUrl + path, data: datas);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw (response);
    }
  }

  Future<Response> deleteData({required String path}) async {
    final Response response = await dio.delete(baseUrl + path);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw (response);
    }
  }

  Future<String> getTestToken({required String tokenToTest}) async {
    dio.options.headers['Authorization'] = 'Beaer $tokenToTest';
    final response = await dio.get("$baseUrl/auth/handshake");
    if (response.statusCode == 200) {
      setToken(tokenToTest);
      return response.data['username'];
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
        "name": response.data['username'],
        "httpCode": response.statusCode
      };
      setToken(response.data['token']);
      SharedHandler().addToken(token);
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

  Future<Scan> getUpdatedStatut(
      {required String bordereau, required int state}) async {
    final response = await getData(
        path: "/facteur/update?bordereau=$bordereau&state=$state");
    if (response.statusCode == 201) {
      Map<String, dynamic> data = response.data['data'];
      Scan scan = Scan.fromJson(data);
      print(scan);
      return scan;
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

  Future<String> deleteStatut({required String bordereau}) async {
    final response =
        await deleteData(path: "/facteur/statut?bordereau=$bordereau");
    Map data = response.data;
    if (response.statusCode == 201) {
      return data['message'];
    } else {
      throw (response);
    }
  }

  Future<List<Scan>> getMesScans() async {
    final response = await getData(path: '/facteur/mes-scans');
    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      List<Scan> scans = data.map<Scan>((dynamic jsonScan) {
        return Scan.fromJson(jsonScan);
      }).toList();
      return scans;
    } else {
      throw(response);
    }
  }
  
  Future<List<Scan>> getSearchScan({required String bordereau}) async {
    final response = await getData(path: "/facteur/recherche-scans?bordereau=$bordereau");
    if (response.statusCode == 200) {
      Map data = response.data;
      print(data);
      List<Scan> scans = data['sc'].map<Scan>((dynamic jsonScan) {
        return Scan(
            date: DateTime.parse(jsonScan['date']),
            etat: jsonScan['s']['statutCode'],
            courrier: Courrier(
                id: data['id'],
                bordereau: data['bordereau'],
                type: data['type']));
      }).toList();
      return scans;
    } else {
      throw(response);
    }
  }
}
