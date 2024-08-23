import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/error/network/http.dart';
import '../../../../core/error/constants/constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/fialures.dart';
import '../model/user_model.dart';

abstract class RemoteDataSource{
  Future<UserModel>signUp(UserModel user);
  Future<UserModel>logIn(UserModel user);
  Future<UserModel>getCurrentUser();
  
}

class RemoteDataSourceImpl implements RemoteDataSource{
  final HttpClient client;
  final String _baseUrl;
  RemoteDataSourceImpl({required this.client}): _baseUrl= '$baseUrl/auth';

  @override
  Future<UserModel> logIn(UserModel user) async{
    
    final response = await client.post('$_baseUrl/login',user.toJson());

    print('///////////////${response.body}');
    if (response.statusCode == 201){
      return UserModel.fromJson(json.decode(response.body)['data']);
    }else{
      throw ServerException();
    }
  }


  @override
  Future<UserModel> signUp(UserModel user) async{
    
    final response = await client.post('$_baseUrl/register',user.toJson());

    print('============================${response.body}');
    if(response.statusCode == 201){
      return UserModel.fromJson(json.decode(response.body)['data']);
    }else{
      throw ServerException();
    }
    
  }

  @override
  Future<UserModel> getCurrentUser()async{
    final response = await client.get('$baseUrl/users/me');

    if (response.statusCode == 200){
      return UserModel.fromJson(json.decode(response.body)['data']);
    }else if(response.statusCode == 401){
      throw AuthenticationException.tokenExpired();
    }else{
      throw ServerException('response.body');
    }
  }
}