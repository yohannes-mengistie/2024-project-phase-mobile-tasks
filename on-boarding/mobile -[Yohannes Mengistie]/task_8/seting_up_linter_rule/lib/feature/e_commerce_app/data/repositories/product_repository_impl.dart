import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/fialures.dart';
import '../../../../core/error/network/network_info.dart';
import '../../domain/entities/e_commerce.dart';
import '../../domain/repository/e_commerce_repository.dart';
import '../data_sources/product_local_data_source.dart';
import '../data_sources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ECommerceRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Fialure, Unit>> deleteProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await remoteDataSource.getProductById(id);
        await remoteDataSource.deleteProduct(id);
        await localDataSource.deleteCachedProduct(id);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure('Failed to delete product from server.'));
      }
    } else {
      return Left(ServerFailure('No internet connection.'));
    }
  }

  @override
  Future<Either<Fialure, List<Product>>> getAllProduct() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProduct();
        localDataSource.cacheProducts(remoteProducts);
        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure('Failed to fetch products from server.'));
      }
    } else {
      try {
        final localProducts = await localDataSource.getCachedProducts();
        return Right(localProducts);
      } on CacheException {
        return Left(CacheFailure('No products available in cache.'));
      }
    }
  }

  @override
  Future<Either<Fialure, Product>> insertProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final insertedProduct = await remoteDataSource.insertProduct(product);
        await localDataSource.cacheProduct(insertedProduct);
        return Right(insertedProduct);
      } on ServerException {
        return Left(ServerFailure('Failed to insert product to server.'));
      }
    } else {
      return Left(ServerFailure('No internet connection.'));
    }
  }

  @override
  Future<Either<Fialure, Product>> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final updatedProduct = await remoteDataSource.updateProduct(product);
        await localDataSource.cacheProduct(updatedProduct);
        return Right(updatedProduct);
      } on ServerException {
        return Left(ServerFailure('Failed to update product on server.'));
      }
    } else {
      return Left(ServerFailure('No internet connection.'));
    }
  }

  @override
  Future<Either<Fialure, Product>> getProductById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getProductById(id);
        await localDataSource.cacheProduct(remoteProducts);
        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure('Failed to fetch products from server.'));
      }
    } else {
      try {
        final localProducts = await localDataSource.getCatchedProductById(id);
        return Right(localProducts);
      } on CacheException {
        return Left(CacheFailure('No products available in cache.'));
      }
    }
  }
}
