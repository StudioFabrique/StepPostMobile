import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/infos_courriers.dart';
import '../models/scan.dart';
import '../models/statut.dart';
import '../services/api_service.dart';
import '../services/shared_handler.dart';

class DataRepository with ChangeNotifier {
  APIService api = APIService();
  bool _isLogged = false;
  String _currentScan = "";
  int _currentIndex = 0;
  InfosCourrier? _courrier;
  List<Statut> _etats = [];
  List<Scan> _myScans = [];
  bool _hasBeenUpdated = false;
  bool _welcome = false;

  //  getters

  bool get isWelcome => _welcome;
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

  //  setters

  set isWelcome(bool value) {
    _welcome = value;
  }

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

  set courrier(InfosCourrier? value) {}

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
        Map<String, dynamic> data = {"httpCode": 401};
        return data;
      }
      rethrow;
    }
  }

  Future<void> getCurrentScan() async {
    if (!_welcome) _welcome = true;
    try {
      _courrier = await api.getCurrentScan(bordereau: _currentScan);
      hasBeenUpdated = false;
      notifyListeners();
    } on DioError catch (e) {
      if (checkDioError(e)) logout();
      if (e.response?.statusCode == 404) {
        _courrier = null;
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
      _courrier!.etat = state;
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

  Future<Map<String, dynamic>?> getTestToken(
      {required String tokenToTest}) async {
    try {
      final response = await api.getTestToken(tokenToTest: tokenToTest);
      Map<String, dynamic> data = {"code": 200, "username": response};
      if (response.isNotEmpty) {
        _isLogged = true;
        if (_etats.isEmpty) {
          await getStatutsList();
        }
        notifyListeners();
        return data;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) return {"code": 403};
      rethrow;
    }
    return null;
  }

  Future<String?> deleteStatut(
      {required int bordereau, required int state}) async {
    try {
      print(state);
      if (hasBeenUpdated) {
        //int oldEtat = _courrier!.etat;
        final response =
            await api.deleteStatut(bordereau: bordereau.toString());
        _myScans.removeAt(0);
        hasBeenUpdated = false;
        _courrier!.etat = state;
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
    _myScans = [];
    _courrier = null;
    _welcome = false;
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
