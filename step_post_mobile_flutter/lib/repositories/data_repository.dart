import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:step_post_mobile_flutter/models/infos_courriers.dart';
import 'package:step_post_mobile_flutter/models/scan.dart';
import 'package:step_post_mobile_flutter/models/statut.dart';
import 'package:step_post_mobile_flutter/services/api_service.dart';
import 'package:step_post_mobile_flutter/services/shared_handler.dart';

import '../models/search_scan.dart';

class DataRepository with ChangeNotifier {
  APIService api = APIService();
  String _name = "";
  bool _isLogged = false;
  bool _isLoading = false;
  String _currentScan = "";
  int _currentIndex = 0;
  InfosCourrier? _courrier;
  bool _hasCourrier = false;
  List<Statut> _etats = [];
  List<Scan> _myScans = [];
  bool _hasBeenUpdated = false;

  //  getters

  String get name => _name;
  bool get isLogged => _isLogged;
  bool get isLoading => _isLoading;
  String get currentScan => _currentScan;
  int get currentIndex => _currentIndex;
  InfosCourrier? get courrier => _courrier;
  bool get hasCourrier => _hasCourrier;
  String get etat => getEtat(_courrier!.etat);
  String getEtat(int value) {
    int index = _etats.indexWhere((element) => element.statutCode == value);
    return _etats[index].etat;
  }
  List<Scan> get mesScans => _myScans;

  bool get hasBeenUpdated => _hasBeenUpdated;
  List<Scan> get myScans => _myScans;

  //  setters

  set isLogged(bool value) {
    _isLogged = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  set currentScan(String value) {
    _currentScan = value;
    notifyListeners();
  }

  set courrier(InfosCourrier? value) {
    _courrier = value;
  }

  set hasCourrier(bool value) {
    _hasCourrier = value;
  }

  set myScans(List<Scan> value) {
    _myScans = value;
    notifyListeners();
  }

  set hasBeenUpdated(bool value) {
    _hasBeenUpdated = value;
  }

  //  connexion
  Future<int?> login(
      {required String username, required String password}) async {
    try {
      isLoading = true;
      final Map<String, dynamic> data =
          await api.login(username: username, password: password);
      //  token = data['token']!;
      _name = data['name']!;
      if (_etats.isEmpty) {
        await getStatutsList();
      }
      isLogged = true;
      isLoading = false;
      return data['httpCode'];
    } catch (response) {
      isLoading = false;
      if (response.toString().contains("401")) {
        return 401;
      }
      rethrow;
    }
  }

  Future<void> getCurrentScan() async {
    try {
      isLoading = true;
      _courrier = await api.getCurrentScan(bordereau: _currentScan);
      hasCourrier = true;
      isLoading = false;
      hasBeenUpdated = false;
      notifyListeners();
    } catch (response) {
      print(" ERROR ERROR ERROR ERROR ${response}");
      if (response.toString().contains("404")) {
        hasCourrier = false;
      }
      isLoading = false;
      rethrow;
    }
  }

  Future<void> getStatutsList() async {
    try {
      _etats = await api.getStatutsList();
      notifyListeners();
    } on Response catch (response) {
      print(response);
      rethrow;
    }
  }

  Future<void> getUpdatedStatuts({required int state}) async {
    try {
      final response =
          await api.getUpdatedStatut(bordereau: _currentScan, state: state);
      await getCurrentScan();
      hasBeenUpdated = true;
      notifyListeners();
    } on Response catch (response) {
      print(response);
      rethrow;
    }
  }

  Future<void> postSignature({required dynamic signature}) async {
    try {
      final response = await api.postSignature(
          courrierId: _courrier!.id, signature: signature);
    } on Response catch (response) {
      Map data = response.data;
      print(response);
      rethrow;
    }
  }

  Future<int?> getTestToken({required String tokenToTest}) async {
    isLoading = true;
    try {
      final response = await api.getTestToken(tokenToTest: tokenToTest);
      if (response.isNotEmpty) {
        print("response = $response");
        APIService().token = tokenToTest;
        _isLogged = true;
        _name = response;
        if (_etats.isEmpty) {
          await getStatutsList();
        }
        isLoading = false;
        return 200;
      }
    } catch (response) {
      print("erreur $response");
      isLoading = false;
      if (response.toString().contains('403')) {
        logout();
        return 403;
      }
      rethrow;
    }
    return null;
  }

  Future<String?> deleteStatut({required int bordereau}) async {
    try {
      isLoading = true;
      if (hasBeenUpdated) {
        final response =
            await api.deleteStatut(bordereau: bordereau.toString());
        hasBeenUpdated = false;
        isLoading = false;
        await getCurrentScan();
        return response;
      }
    } catch (response) {
      isLoading = false;
      print(response);
      if (response.toString().contains('403')) {
        return "Le statut n'a pas été supprimé";
      }
      rethrow;
    }
    return null;
  }

  Future<void> getMesScans() async {
    try {
      _myScans = await api.getMesScans();
      print (mesScans);
      notifyListeners();
    } on Response catch(response) {
      print(response);
      rethrow;
    }
  }

  Future<List<SearchScan>> getSearchScan({required String bordereau}) async {
    try {
      return await api.getSearchScan(bordereau: bordereau);
    } on Response catch (response) {
      rethrow;
    }
  }

  onSearchMail(String bordereau) async {
    _currentScan = bordereau;
    await getCurrentScan();
  }

  logout() {
    APIService().token = "";
    SharedHandler().removeToken();
    isLogged = false;
  }
}
