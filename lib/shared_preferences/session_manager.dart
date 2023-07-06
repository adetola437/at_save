import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> saveIfSeen(bool status) async {
    await getSharedPreferences()
        .then((value) => value.setBool('onboard', status));
  }

  Future<bool?> seenOnboardingScreen() async {
    return await getSharedPreferences()
        .then((value) => value.getBool('onboard'));
  }

  Future<void> saveUid(String uid) async {
    await getSharedPreferences().then((value) => value.setString('uid', uid));
  }

  Future<String?> getUid() async {
    return await getSharedPreferences().then((value) => value.getString('uid'));
  }

  Future<void> saveEmail(String email) async {
    await getSharedPreferences()
        .then((value) => value.setString('email', email));
  }

  Future<String?> getEmail() async {
    return await getSharedPreferences()
        .then((value) => value.getString('email'));
  }

  Future<void> saveName(String name) async {
    await getSharedPreferences().then((value) => value.setString('name', name));
  }

  Future<String?> getName() async {
    return await getSharedPreferences()
        .then((value) => value.getString('name'));
  }

  Future<void> saveMessagingToken(String token) async {
    await getSharedPreferences()
        .then((value) => value.setString('token', token));
  }

  Future<String?> getMessagingToken() async {
    return await getSharedPreferences()
        .then((value) => value.getString('token'));
  }
}
