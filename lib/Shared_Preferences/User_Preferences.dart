
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserPreferences
{

  static final UserPreferences  _instance = UserPreferences._();
  late SharedPreferences _sharedPreferences;

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._();
  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
  Future save(User user) async {
    await _sharedPreferences.setBool('logged_in', true);
    await _sharedPreferences.setInt('id', user.id);
    await _sharedPreferences.setString('fullName', user.name);
    await _sharedPreferences.setString('email', user.email);
     await _sharedPreferences.setString('Type', user.type);
    await _sharedPreferences.setString('token', 'Bearer ' + user.accessToken);
  }

  bool get isLoggedIn => _sharedPreferences.getBool('logged_in') ?? false;
  User get user {
    User user = User();
    user.id = _sharedPreferences.getInt('id') ?? 0;
    user.name = _sharedPreferences.getString('fullName') ?? '';
    user.email = _sharedPreferences.getString('email') ?? '';
    user.type = _sharedPreferences.getString('Type') ?? '';
    return user;
  }
  String get token => _sharedPreferences.getString('token') ?? '';

  Future logout() async {
    await _sharedPreferences.clear();
  }



}