import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  
  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }
///Save onboarding screen status when seen
  Future<void> saveIfSeen(bool status) async {
    await getSharedPreferences()
        .then((value) => value.setBool('onboard', status));
  }
/// Get onboarding screen status when seen
  Future<bool?> seenOnboardingScreen() async {
    return await getSharedPreferences()
        .then((value) => value.getBool('onboard'));
  }
/// saves user uid for easy query to database
  Future<void> saveUid(String uid) async {
    await getSharedPreferences().then((value) => value.setString('uid', uid));
  }
//Get the user uid 
  Future<String?> getUid() async {
    return await getSharedPreferences().then((value) => value.getString('uid'));
  }
/// Save the user email for easy display
  Future<void> saveEmail(String email) async {
    await getSharedPreferences()
        .then((value) => value.setString('email', email));
  }
///Get the user email
  Future<String?> getEmail() async {
    return await getSharedPreferences()
        .then((value) => value.getString('email'));
  }
///Saves the users name 
  Future<void> saveName(String name) async {
    await getSharedPreferences().then((value) => value.setString('name', name));
  }
///Gets the logged in users name
  Future<String?> getName() async {
    return await getSharedPreferences()
        .then((value) => value.getString('name'));
  }
///Save the messaging token of the particular device for push notification
  Future<void> saveMessagingToken(String token) async {
    await getSharedPreferences()
        .then((value) => value.setString('token', token));
  }
///gets the users device token for push notification
  Future<String?> getMessagingToken() async {
    return await getSharedPreferences()
        .then((value) => value.getString('token'));
  }
Future<void> clearSharedPreferences() async {
  SharedPreferences prefs = await getSharedPreferences();
  await prefs.clear();
}
  // Future<void> saveVisibility(bool visible) async {
  //   await getSharedPreferences()
  //       .then((value) => value.setBool('visible', visible));
  // }

  //   Future<bool?> getVisibility() async {
  //   return await getSharedPreferences()
  //       .then((value) => value.getBool('visible'));
  // }
}
