import '/../models/shared_preference_manager.dart';
import 'package:flutter/foundation.dart';

class SessionManager with ChangeNotifier {
  SessionManager._privateConstructor();
  static SessionManager? _sessionManager;
  bool _isSessionExpired = false;

  static SessionManager getInstance(){
    _sessionManager ??= SessionManager._privateConstructor();
    return _sessionManager!;
  }

  bool get isSessionExpired => _isSessionExpired;

  Future<void> expireSession() async {
    _isSessionExpired = true;
    await SharedPreferenceManager.clearSharedPreferences();
    notifyListeners();
  }

  Future<void> expireSessionSilently() async {
    _isSessionExpired = true;
    await SharedPreferenceManager.clearSharedPreferences();
  }

  void resetSession() {
    _isSessionExpired = false;
    notifyListeners();
  }
}