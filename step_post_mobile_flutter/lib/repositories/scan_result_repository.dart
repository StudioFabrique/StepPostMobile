import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:step_post_mobile_flutter/models/infos_courriers.dart';
import 'package:step_post_mobile_flutter/repositories/data_repository.dart';
import 'package:step_post_mobile_flutter/services/api_service.dart';

class ScanResultRepository with ChangeNotifier {
  APIService api = APIService();
  InfosCourrier? _mail;
  bool _error404 = true;
  bool _hasBeenUpdated = false;

  InfosCourrier? get mail => _mail;
  bool get error404 => _error404;
  bool get hasBeenUpdated => _hasBeenUpdated;

  Future<void> getCurrentScan({required String bordereau}) async  {
    try {
      _mail = await api.getCurrentScan(bordereau: bordereau);
      _error404 = false;
      print("coucou scan");
      notifyListeners();
    } on DioError catch(e) {
      print ("bye bye");
      if (checkDioError(e))  DataRepository.logout();
    }
  }

  bool checkDioError(DioError e) {
    return e.response?.statusCode == 403 || e.response?.statusCode == 401;
  }
}