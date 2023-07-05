import 'package:shared_preferences/shared_preferences.dart';
class CacheData {
  static late SharedPreferences sharedPreferences;
  static  cacheInit() async {
    sharedPreferences = await  SharedPreferences.getInstance();
  }
  static const likedKey = 'liked_key';
  late bool liked = false;

  static Future<bool> setData({required String key, required dynamic value})async{
    if(value is bool) {
      await sharedPreferences.setBool(key, value);
      return true;
    }
    if(value is String) {
      await sharedPreferences.setString(key, value);
      return true;
    }
    return false;

}

  static dynamic getData({required String key}){
    return sharedPreferences.get(key);
}

  static void _restorePersistedPref()async{
    var liked = sharedPreferences.getBool(likedKey);
  }




}