import 'dart:io';
import '../../../../core/error/network/http.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/fialures.dart';
import '../../../../core/error/network/network_info.dart';
import '../../domain/entities/authentication.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repository/authentication_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';
import '../model/user_model.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository{
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final HttpClient client;

  AuthenticationRepositoryImpl({required this.remoteDataSource,required this.localDataSource,required this.networkInfo,required this.client});
  @override
  Future<Either<Fialure, UserModel>> logIn(UserModel user) async{
    if (await networkInfo.isConnected){
      try{
        final accessToken = await remoteDataSource.logIn(user);
        client.authToken = accessToken.token!;
        final userAuth = await remoteDataSource.getCurrentUser();
       
        await localDataSource.cacheUser(userAuth);
        return Right(userAuth);
      }on ServerException{
        return Left(ServerFailure('faild to login'));
      }
    }else{
      return Left(ConnectionFailure('Connection Fialure'));
    }
  }

  @override
  Future<Either<Fialure, void>> logOut() async{
    
    try{
      await localDataSource.clearCach();
      return const Right(null);
    }catch(e){
      return Left(CacheFailure('failed to logOut'));
    }
   
  }

  @override
  Future<Either<Fialure, UserModel>> signUp(UserModel user) async{
    if(await networkInfo.isConnected){
      try{
        await remoteDataSource.signUp(user);
        final userAuth = logIn(user);
        
        return userAuth;
      }on ServerException{
        return Left(ServerFailure('failed to sigUp'));
      }
    }else{
      final userAuth = await localDataSource.logInByCached();
      return Right(userAuth);
    }
  }

  @override
  Future<Either<Fialure,UserModel>> getCurrentUser()async{
    try{
      final user = await localDataSource.logInByCached();
      client.authToken = user.token!;
      return Right(user);
    }on CacheException{
      return  Left(AuthFailure.tokenExpired());
    }
  }
  
}