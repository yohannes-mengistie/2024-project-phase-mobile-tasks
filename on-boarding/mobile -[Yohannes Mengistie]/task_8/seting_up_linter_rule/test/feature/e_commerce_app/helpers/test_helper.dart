import 'dart:io';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:seting_up_linter_rule/feature/authentication/data/data_sources/local_data_source.dart';
import 'package:seting_up_linter_rule/feature/authentication/data/data_sources/remote_data_source.dart';
import 'package:seting_up_linter_rule/feature/authentication/domain/repository/authentication_repository.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/presentation/bloc/e_commerce_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/annotations.dart';
//import '../../../../core/error/network/http.dart';
import 'package:seting_up_linter_rule/core/error/network/network_info.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/data_sources/product_local_data_source.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/data_sources/product_remote_data_source.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/repository/e_commerce_repository.dart';

@GenerateMocks([
  ECommerceRepository,
  ProductRemoteDataSource,
  ProductLocalDataSource,
  NetworkInfo,
  InternetConnectionChecker,
  SharedPreferences ,
  HttpClient,
  AuthenticationRepository,
  RemoteDataSource,
  LocalDataSource
  
])
void main() {}
