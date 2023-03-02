import 'package:shared_preferences/shared_preferences.dart';

class CacthHelper{
 static SharedPreferences? sharedPreferences;
 static inti()async{
  sharedPreferences= await SharedPreferences.getInstance();
 }
static Future<bool>SaveData(String key,String uid)async{
return  await sharedPreferences!.setString(key, uid);
 }
static String? getData(String key){
 return  sharedPreferences?.getString(key);

 }
static Future<bool> clearKey(String key)async{
  return sharedPreferences!.remove(key);
}
}