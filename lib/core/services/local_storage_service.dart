
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {

  Future<void> saveUid(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', value);
  }

  Future<String> readUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('uid');
    return stringValue;
  }

  Future<void> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("uid");
  }
}
