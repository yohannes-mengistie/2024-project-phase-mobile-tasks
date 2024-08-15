import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/error/network/network_info.dart';
import 'core/utils/input_converter.dart';
import 'feature/e_commerce_app/data/data_sources/product_local_data_source.dart';
import 'feature/e_commerce_app/data/data_sources/product_remote_data_source.dart';
import 'feature/e_commerce_app/data/repositories/product_repository_impl.dart';
import 'feature/e_commerce_app/domain/repository/e_commerce_repository.dart';
import 'feature/e_commerce_app/domain/usecase/delete_product.dart';
import 'feature/e_commerce_app/domain/usecase/get_all_product.dart';
import 'feature/e_commerce_app/domain/usecase/insert_product.dart';
import 'feature/e_commerce_app/domain/usecase/update_product.dart';
import 'feature/e_commerce_app/presentation/bloc/e_commerce_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Features - Ecommerce App
  // Bloc
  sl.registerFactory(
    () => ECommerceBloc(sl()), // ECommerceBloc expects an ECommerceRepository
  );

  // Use cases
  sl.registerLazySingleton(() => DeleteProduct(sl()));
  sl.registerLazySingleton(() => GetAllProduct(sl()));
  sl.registerLazySingleton(() => InsertProduct(sl()));
  sl.registerLazySingleton(() => UpdateProduct(sl()));

  // Repository
  sl.registerLazySingleton<ECommerceRepository>(() => ProductRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // Data Sources
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl()));

  // Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
