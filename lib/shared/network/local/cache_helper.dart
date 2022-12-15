import 'package:shared_preferences/shared_preferences.dart';

//حفظ اعدادات الثيم عند فتح التطبيق كل مره
class CacheHelper {
  static late SharedPreferences sharedpreferences;
  static init() async {
    sharedpreferences = await SharedPreferences.getInstance();
  }

  //set data
  static Future<bool> putData(
      {required String key, required bool value}) async {
    return await sharedpreferences.setBool(key, value);
  }

  //get data
  static bool? getData({required String key}) {
    return sharedpreferences.getBool(key);
  }
}
//flutter build apk --split-per-abi