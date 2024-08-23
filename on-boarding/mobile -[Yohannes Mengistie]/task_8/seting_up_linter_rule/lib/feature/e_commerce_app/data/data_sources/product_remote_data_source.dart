import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/error/network/http.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../core/error/constants/constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/e_commerce.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> updateProduct(ProductModel product);
  Future<ProductModel> insertProduct(ProductModel product);
  Future<Unit> deleteProduct(String id);
  Future<List<ProductModel>> getAllProduct();
  Future<ProductModel> getProductById(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final HttpClient client;
  final String _baseUrl;

  ProductRemoteDataSourceImpl({required this.client}):_baseUrl='$baseUrl/products';

  String ImageProvider(String imageUrl) {
    if (imageUrl.toLowerCase().endsWith('png')) {
      return 'png';
    } else if (imageUrl.toLowerCase().endsWith('jpg') ||
        imageUrl.toLowerCase().endsWith('jpeg')) {
      return 'jpeg';
    } else {
      throw UnsupportedError('Unsupported Image Format');
    }
  }

  @override
  Future<Unit> deleteProduct(String id) async {
    final response = await client.delete('$_baseUrl/$id'
    );
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getAllProduct() async {
    final response = await client.get(
     _baseUrl
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['data'];

      return jsonList
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    final response = await client.get(
      '$_baseUrl/$id'
    );

    print(response.body);
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body)['data'];
      return ProductModel.fromJson(jsonMap);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> insertProduct(ProductModel product) async {
    try {
      final response = await client.uploadFile(_baseUrl, HttpMethod.post, {
        'name': product.name,
        'description': product.description,
        'price': product.price.toString()
      }, [
        UploadFile(
          key: 'image',
          path: product.imageUrl,
          
        )
      ]);

    
    // request.fields.addAll({
    //   'name': product.name,
    //   'description': product.description,
    //   'price': product.price.toString(),
    // });

    // print(
    //     '================================================${product.imageUrl}');
    // if (product.imageUrl.isNotEmpty) {
    //   String imageType = ImageProvider(product.imageUrl);
    //   request.files.add(await http.MultipartFile.fromPath(
    //       'image', product.imageUrl,
    //       contentType: MediaType('image', imageType)));
    // }

    // final response = await request.send();
    print(response.statusCode);

    if (response.statusCode == 201) {
      
      print('\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\${responseBody}');
      final jsonMap = json.decode(response.body);

      return ProductModel.fromJson(jsonMap);
    } else {
      throw ServerException(response.body);
    }
  }catch(e){
    throw ServerException(e.toString());
  }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
     try {
      final response =
          await client.put('$_baseUrl/${product.id}', product.toJson());

      if (response.statusCode == 200) {
        return ProductModel.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw ServerException(response.body);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  //   final productId = product.id;
  //   final jsonBody = jsonEncode({
  //     'name': product.name,
  //     'description': product.description,
  //     'price': product.price,
  //   });

  //   final url = Uri.parse(
  //       '${'https://g5-flutter-learning-path-be.onrender.com/api/v1/products'}/$productId');
  //   final response = await client.put(
  //     url,
  //     body: jsonBody,
  //     headers: {'Content-Type': 'application/json'},
  //   );

  //   print('===========Status code: ${response.statusCode}');
  //   print('Response body: ${response.body}');

  //   if (response.statusCode == 200) {
  //     return ProductModel.fromJson(json.decode(response.body)['data']);
  //   } else {
  //     throw ServerException(
  //         'Failed to update product on server: ${response.reasonPhrase}');
  //   }
  // }
}
