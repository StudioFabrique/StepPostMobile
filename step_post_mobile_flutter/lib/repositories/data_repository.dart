import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:step_post_mobile_flutter/models/infos_courriers.dart';
import 'package:step_post_mobile_flutter/models/scan.dart';
import 'package:step_post_mobile_flutter/models/statut.dart';
import 'package:step_post_mobile_flutter/services/api_service.dart';
import 'package:step_post_mobile_flutter/services/shared_handler.dart';

class DataRepository with ChangeNotifier {
  APIService api = APIService();
  bool _isLogged = false;
  String _currentScan = "";
  int _currentIndex = 0;
  InfosCourrier? _courrier;
  List<Statut> _etats = [];
  List<Scan> _myScans = [];
  bool _hasBeenUpdated = false;
  bool _error404 = true;

  //  getters

  bool get isLogged => _isLogged;
  String get currentScan => _currentScan;
  int get currentIndex => _currentIndex;
  InfosCourrier? get courrier => _courrier;
  String get etat => getEtat(_courrier!.etat);
  String getEtat(int value) {
    int index = _etats.indexWhere((element) => element.statutCode == value);
    return _etats[index].etat;
  }
  List<Scan> get mesScans => _myScans;
  bool get hasBeenUpdated => _hasBeenUpdated;
  List<Scan> get myScans => _myScans;
  bool get error404 => _error404;

  //  setters

  set isLogged(bool value) {
    _isLogged = value;
  }

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  set currentScan(String value) {
    _currentScan = value;
  }

  set courrier(InfosCourrier? value) {
  }

  set myScans(List<Scan> value) {
    _myScans = value;
  }

  set hasBeenUpdated(bool value) {
    _hasBeenUpdated = value;
  }

  /// connexion de l'utilisateur puis chargement de la liste des statuts
  Future<Map<String, dynamic>?> login(
      {required String username, required String password}) async {
    try {
      final Map<String, dynamic> data =
          await api.login(username: username, password: password);
      if (_etats.isEmpty) {
        await getStatutsList();
      }
      isLogged = true;
      notifyListeners();
      return data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        Map<String, dynamic> data = {
          "httpCode": 401
        };
        return data;
      }
      rethrow;
    }
  }

  Future<void> getCurrentScan() async {
    try {
      _courrier = await api.getCurrentScan(bordereau: _currentScan);
      hasBeenUpdated = false;
      _error404 = false;
      notifyListeners();
    } on DioError catch (e) {
      if (checkDioError(e)) logout();
      if (e.response?.statusCode == 404) {
        _error404 = true;
        notifyListeners();
      }
      rethrow;
    }
  }

  Future<void> getStatutsList() async {
    try {
      _etats = await api.getStatutsList();
      notifyListeners();
    } on DioError catch (e) {
      if (checkDioError(e)) logout();
      rethrow;
    }
  }

  Future<void> getUpdatedStatuts({required int state}) async {
    try {
      final response =
          await api.getUpdatedStatut(bordereau: _currentScan, state: state);
      await getCurrentScan();
      hasBeenUpdated = true;
      if (_myScans.isEmpty) {
        await getMesScans();
        if (_myScans.isEmpty) _myScans.insert(0, response);
      } else {
        _myScans.insert(0, response);
      }
      notifyListeners();
    } on DioError catch (e) {
      if (checkDioError(e)) logout();
      rethrow;
    }
  }

  Future<void> postSignature({required dynamic signature}) async {
    try {
      await api.postSignature(courrierId: _courrier!.id, signature: signature);
    } on DioError catch (e) {
      if (checkDioError(e)) logout();
      rethrow;
    }
  }

  Future<int?> getTestToken({required String tokenToTest}) async {
    try {
      final response = await api.getTestToken(tokenToTest: tokenToTest);
      if (response.isNotEmpty) {
        _isLogged = true;
        if (_etats.isEmpty) {
          await getStatutsList();
        }
        notifyListeners();
        return 200;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) return 403;
      rethrow;
    }
    return null;
  }

  Future<String?> deleteStatut({required int bordereau}) async {
    try {
      if (hasBeenUpdated) {
        final response =
            await api.deleteStatut(bordereau: bordereau.toString());
        _myScans.removeAt(0);
        hasBeenUpdated = false;
        await getCurrentScan();
        notifyListeners();
        return response;
      }
    } on DioError catch (e) {
      if (checkDioError(e)) logout();
      rethrow;
    }
    return null;
  }

  Future<void> getMesScans() async {
    try {
      _myScans = await api.getMesScans();
      notifyListeners();
    } on DioError catch (e) {
      if (checkDioError(e)) logout();
      rethrow;
    }
  }

  Future<List<Scan>> getSearchScan({required String bordereau}) async {
    try {
      return await api.getSearchScan(bordereau: bordereau);
    } on DioError catch (e) {
      if (checkDioError(e)) logout();
      if (e.response?.statusCode == 404) return [];
      rethrow;
    }
  }

  onSearchMail(String bordereau) async {
    _currentScan = bordereau;
    await getCurrentScan();
  }

  logout() {
    APIService().setToken("");
    SharedHandler().removeToken();
    isLogged = false;
    notifyListeners();
  }

  bool checkDioError(DioError e) {
    return e.response?.statusCode == 403 || e.response?.statusCode == 401;
  }

  Future<void> initData() async {
    if (_myScans.isEmpty) {
      await getMesScans();
    }
  }
}
