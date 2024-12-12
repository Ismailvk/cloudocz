import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  SharedPreference._();
  static final _instance = SharedPreference._();
  static SharedPreference get instance => _instance;

  static const String token = 'token';

  late SharedPreferences sharedPref;

  initStorage() async => sharedPref = await SharedPreferences.getInstance();

  storeToken(String userToken) async {
    await sharedPref.setString(token, userToken);
  }

  String? getToken() => sharedPref.getString(token);

  removeToken() async {
    await sharedPref.remove(token);
  }
}
