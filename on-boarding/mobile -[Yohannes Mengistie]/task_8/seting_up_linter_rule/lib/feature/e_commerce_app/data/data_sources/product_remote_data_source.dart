import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/constants/constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/e_commerce.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<Product> updateProduct(Product product);
  Future<Product> insertProduct(Product product);
  Future<Unit> deleteProduct(int id);
  Future<List<Product>> getAllProduct();
  Future<Product> getProductById(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});
  @override
  Future<Unit> deleteProduct(int id) async {
    final response = await client.delete(
      Uri.parse('${Urls.deleteProductUrl}/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Product>> getAllProduct() async {
    final response = await client.get(
      Uri.parse(Urls.productsUrl),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((items) => ProductModel.fromJson(items)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> getProductById(int id) async {
    final response = await client.get(
      Uri.parse('${Urls.productUrl}/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return ProductModel.fromJson(jsonMap);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> insertProduct(Product product) async {
    final response = await client.post(
      Uri.parse(Urls.postProductUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode((product as ProductModel).toJson()),
    );
    if (response.statusCode == 201) {
      final jsonMap = json.decode(response.body);
      return ProductModel.fromJson(jsonMap);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Product> updateProduct(Product product) async {
    final response = await client.put(
      Uri.parse('${Urls.putProductUrl}/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode((product as ProductModel).toJson()),
    );

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return ProductModel.fromJson(jsonMap);
    } else {
      throw ServerException();
    }
  }
}
