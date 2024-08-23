import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../model/user_model.dart';


const CACHED_USER = 'CACHED_USER';
abstract class LocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<void> clearCach();
  Future<UserModel> logInByCached();

}

class LocalDataSourceImpl implements LocalDataSource{
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});


  @override
  Future<void> cacheUser(UserModel user) {
    return sharedPreferences.setString(CACHED_USER,json.encode(user.toJson()));
  }

  @override
  Future<void> clearCach() {
    return sharedPreferences.remove(CACHED_USER);
  }

  @override
  Future<UserModel> logInByCached() {
    final jsonString = sharedPreferences.getString(CACHED_USER);
    if (jsonString != null) {
      return Future.value(UserModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
  }