import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/e_commerce.dart';
import '../models/product_model.dart';

const CACHED_PRODUCTS = 'CACHED_PRODUCTS';

abstract class ProductLocalDataSource {
  Future<void> cacheProduct(Product product);
  Future<void> cacheProducts(List<Product> items);
  Future<void> deleteProduct(int id);
  Future<void> deleteCachedProduct(int id);
  Future<List<Product>> getCachedProducts();
  Future<Product> getCatchedProductById(int id);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheProduct(Product product) async {
    final productModel = product as ProductModel;
    final String jsonString = json.encode(productModel.toJson());
    await sharedPreferences.setString(
        'CACHED_PRODUCT_${product.id}', jsonString);
  }

  @override
  Future<void> cacheProducts(List<Product> items) async {
    final List<String> jsonProductList = items
        .map((product) => json.encode((product as ProductModel).toJson()))
        .toList();
    await sharedPreferences.setStringList(CACHED_PRODUCTS, jsonProductList);
  }

  @override
  Future<void> deleteProduct(int id) async {
    await sharedPreferences.remove('CACHED_PRODUCT_$id');
  }

  @override
  Future<void> deleteCachedProduct(int id) async {
    await deleteProduct(id);
  }

  @override
  Future<List<Product>> getCachedProducts() async {
    final jsonStringList = sharedPreferences.getStringList(CACHED_PRODUCTS);
    if (jsonStringList != null) {
      final List<Product> productList = jsonStringList
          .map((jsonProduct) => ProductModel.fromJson(json.decode(jsonProduct)))
          .toList();
      return productList;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<Product> getCatchedProductById(int id) async {
    final jsonString = sharedPreferences.getString('CACHED_PRODUCT_$id');
    if (jsonString != null) {
      return ProductModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException();
    }
  }
}
