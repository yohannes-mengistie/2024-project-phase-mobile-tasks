import 'package:dartz/dartz.dart';

import '../../domain/entities/e_commerce.dart';

abstract class ProductRemoteDataSource {
  Future<Product> updateProduct(Product product);
  Future<Product> insertProduct(Product product);
  Future<Unit> deleteProduct(int id);
  Future<List<Product>> getAllProduct();
  Future<Product> getProductById(int id);
}
