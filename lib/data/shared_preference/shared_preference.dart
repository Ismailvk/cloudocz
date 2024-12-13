import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  SharedPreference._();
  static final _instance = SharedPreference._();
  static SharedPreference get instance => _instance;

  static const String tokenKey = 'token';
  static const String imageKey = 'image';
  static const String nameKey = 'name';
  static const String positionKey = 'position';

  late SharedPreferences sharedPref;

  Future<void> initStorage() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  Future<void> storeToken(String userToken) async {
    await sharedPref.setString(tokenKey, userToken);
  }

  String? getToken() => sharedPref.getString(tokenKey);

  Future<void> storeImage(String imageUrl) async {
    await sharedPref.setString(imageKey, imageUrl);
  }

  String? getImage() => sharedPref.getString(imageKey);

  Future<void> storeName(String userName) async {
    await sharedPref.setString(nameKey, userName);
  }

  String? getName() => sharedPref.getString(nameKey);

  Future<void> storePosition(String userPosition) async {
    await sharedPref.setString(positionKey, userPosition);
  }

  String? getPosition() => sharedPref.getString(positionKey);

  Future<void> clearAll() async {
    await sharedPref.remove(tokenKey);
    await sharedPref.remove(imageKey);
    await sharedPref.remove(nameKey);
    await sharedPref.remove(positionKey);
  }
}
