import 'package:dio/dio.dart';

import '../models/courrier.dart';
import '../models/infos_courriers.dart';
import '../models/scan.dart';
import '../models/statut.dart';
import './shared_handler.dart';
import '../utils/api.dart';

class APIService {
  static final APIService _instance = APIService._internal();

  late String baseUrl;
  late Dio dio;
  String accessToken = "";
  String refreshToken = "";

  factory APIService() => _instance;

  APIService._internal() {
    baseUrl = API().url;
    dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request, handler) async {
        if (accessToken.isNotEmpty) {
          request.headers['Authorization'] = 'Bearer $accessToken';
        } else {
          await setToken();
          request.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(request);
      },
      onError: (e, handler) async {
        if (e.response?.statusCode == 401) {
          try {
            final response = await dio.post("$baseUrl/auth/refreshtoken",
                data: {'refreshToken': refreshToken});
            if (response.statusCode == 200) {
              //get new tokens ...
              await SharedHandler().addTokens({
                "accessToken": response.data['accessToken'],
                "refreshToken": response.data['refreshToken']
              });
              await setToken();
              //set bearer
              e.requestOptions.headers["Authorization"] = "Bearer $accessToken";
              //create request with new access token
              final opts = Options(
                  method: e.requestOptions.method,
                  headers: e.requestOptions.headers);
              final cloneReq = await dio.request(e.requestOptions.path,
                  options: opts,
                  data: e.requestOptions.data,
                  queryParameters: e.requestOptions.queryParameters);

              return handler.resolve(cloneReq);
            }
          } catch (e) {
            print(e);
          }
        }
        return handler.next(e);
      },
    ));
  }

  setToken() async {
    accessToken = await SharedHandler().getToken("accessToken");
    refreshToken = await SharedHandler().getToken("refreshToken");
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

  Future<String> getHandshake() async {
    final response = await dio.get("$baseUrl/auth/handshake");
    if (response.statusCode == 200) {
      return response.data['username'];
    } else {
      throw (response);
    }
  }

  /// requête pour authentifier un user, stocke le token retourné dans le storage
  Future<Map<String, dynamic>> login(
      {required String username, required String password}) async {
    final response = await dio.post("$baseUrl/auth/facteur/login",
        data: {'username': username, 'password': password});
    if (response.statusCode == 200) {
      Map<String, dynamic> data = {
        "name": response.data['username'],
        "httpCode": response.statusCode
      };
      await SharedHandler().addTokens({
        "accessToken": response.data['accessToken'],
        "refreshToken": response.data['refreshToken']
      });
      await setToken();
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
      throw (response);
    }
  }

  Future<List<Scan>> getSearchScan({required String bordereau}) async {
    final response =
        await getData(path: "/facteur/recherche-scans?bordereau=$bordereau");
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
      throw (response);
    }
  }
}
