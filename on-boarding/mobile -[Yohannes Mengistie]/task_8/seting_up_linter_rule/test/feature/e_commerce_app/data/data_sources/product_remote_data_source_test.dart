// import 'dart:convert';
// import 'package:dartz/dartz.dart';
// import 'package:mockito/mockito.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:seting_up_linter_rule/core/error/constants/constants.dart';
// import 'package:seting_up_linter_rule/core/error/exceptions.dart';
// import 'package:seting_up_linter_rule/feature/e_commerce_app/data/data_sources/product_remote_data_source.dart';
// import 'package:seting_up_linter_rule/feature/e_commerce_app/data/models/product_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// import '../../helpers/json_reader.dart';
// import '../../helpers/test_helper.mocks.dart';

// void main() {
//   late ProductRemoteDataSourceImpl dataSource;
//   late MockClient mockClient;

//   setUp(() {
//     mockClient = MockClient();
//     dataSource = ProductRemoteDataSourceImpl(client: mockClient);
//   });

// // test products
//   final tProductModel = ProductModel(
//     id: '1',
//     name: 'Test Product',
//     description: 'Description 1',
//     price: 100,
//     imageUrl: 'url1',
//   );

//   final tProductModelList = [
//     ProductModel(
//       id: '1',
//       name: 'Test Product 1',
//       description: 'Description 1',
//       price: 100,
//       imageUrl: 'url1',
//     ),
//     ProductModel(
//       id: '2',
//       name: 'Test Product 2',
//       description: 'Description 2',
//       price: 200,
//       imageUrl: 'url2',
//     ),
//   ];

//   final tProductId = '1';

//   group('getAllProduct', () {
//     test(
//         'should return List<ProductModel> when the response code is 200 (success)',
//         () async {
//       // Arrange
//       when(mockClient.get(Uri.parse(Urls.productBaseUrl),
//               headers: anyNamed('headers')))
//           .thenAnswer(
//         (_) async => http.Response(
//             json.encode({
//               'data':
//                   tProductModelList.map((product) => product.toJson()).toList()
//             }),
//             200),
//       );

//       // Act
//       final result = await dataSource.getAllProduct();

//       // Assert
//       expect(result, equals(tProductModelList));
//     });

//     test('should throw a ServerException when the response code is not 200',
//         () async {
//       // Arrange
//       when(mockClient.get(Uri.parse(Urls.productBaseUrl),
//               headers: anyNamed('headers')))
//           .thenAnswer(
//         (_) async => http.Response('Something went wrong', 404),
//       );

//       // Act
//       final call = dataSource.getAllProduct;

//       // Assert
//       expect(() => call(), throwsA(isA<ServerException>()));
//     });
//   });

//   group('getProductById', () {
//     test('should perform a GET request on a URL with id being the endpoint',
//         () async {
//       // Arrange
//       when(mockClient.get(Uri.parse('${Urls.productBaseUrl}/$tProductId'),
//               headers: anyNamed('headers')))
//           .thenAnswer(
//         (_) async => http.Response(json.encode({'data':tProductModel.toJson()}), 200),
//       );

//       // Act
//       dataSource.getProductById(tProductId);

//       // Assert
//       verifyNever(mockClient.get(Uri.parse('${Urls.productBaseUrl}/$tProductId')));
//     });

//     test('should return Product when the response code is 200 (success)',
//         () async {
//       // Arrange
//       when(mockClient.get(Uri.parse('${Urls.productBaseUrl}/$tProductId'),
//               headers: anyNamed('headers')))
//           .thenAnswer(
//         (_) async => http.Response(json.encode({'data':tProductModel.toJson()}), 200),
//       );

//       // Act
//       final result = await dataSource.getProductById(tProductId);

//       // Assert
//       expect(result, equals(tProductModel));
//     });

//     test(
//         'should throw a ServerException when the response code is 404 or other',
//         () async {
//       // Arrange
//       when(mockClient.get(Uri.parse('${Urls.productBaseUrl}/$tProductId'),
//               headers: anyNamed('headers')))
//           .thenAnswer(
//         (_) async => http.Response('Something went wrong', 404),
//       );

//       // Act
//       final call = dataSource.getProductById;

//       // Assert
//       expect(() => call(tProductId), throwsA(isA<ServerException>()));
//     });
//   });

//   group('insertProduct', () {
//     test('should return Product when the response code is 201 (created)',
//         () async {
//       // Arrange
//       when(mockClient.post(
//         Uri.parse(Urls.productBaseUrl),
//         headers: anyNamed('headers'),
//         body: json.encode(tProductModel.toJson()),
//       )).thenAnswer(
//         (_) async => http.Response(json.encode({'data':tProductModel.toJson()}), 201),
//       );

//       // Act
//       final result = await dataSource.insertProduct(tProductModel);

//       // Assert
//       expect(result, equals(tProductModel));
//     });

//     test('should throw a ServerException when the response code is not 201',
//         () async {
//       // Arrange
//       when(mockClient.post(
//         Uri.parse(Urls.productBaseUrl),
//         headers: anyNamed('headers'),
//         body: json.encode(tProductModel.toJson()),
//       )).thenAnswer(
//         (_) async => http.Response('Something went wrong', 400),
//       );

//       // Act
//       final call = dataSource.insertProduct;

//       // Assert
//       expect(() => call(tProductModel), throwsA(isA<ServerException>()));
//     });
//   });

//   group('updateProduct', () {
//     test('should return Product when the response code is 200 (success)',
//         () async {
//       // Arrange
//       when(mockClient.put(
//         Uri.parse('${Urls.productBaseUrl}/${tProductModel.id}'),
//         headers: anyNamed('headers'),
//         body: json.encode(tProductModel.toJson()),
//       )).thenAnswer(
//         (_) async => http.Response(json.encode({'data':tProductModel.toJson()}), 200),
//       );

//       // Act
//       final result = await dataSource.updateProduct(tProductModel);

//       // Assert
//       expect(result, equals(tProductModel));
//     });

//     test('should throw a ServerException when the response code is not 200',
//         () async {
//       // Arrange
//       when(mockClient.put(
//         Uri.parse('${Urls.productBaseUrl}/${tProductModel.id}'),
//         headers: anyNamed('headers'),
//         body: json.encode(tProductModel.toJson()),
//       )).thenAnswer(
//         (_) async => http.Response('Something went wrong', 400),
//       );

//       // Act
//       final call = dataSource.updateProduct;

//       // Assert
//       expect(() => call(tProductModel), throwsA(isA<ServerException>()));
//     });
//   });

//   group('deleteProduct', () {
//     test('should return Unit when the response code is 200 (success)',
//         () async {
//       // Arrange
//       when(mockClient.delete(Uri.parse('${Urls.productBaseUrl}/$tProductId'),
//               headers: anyNamed('headers')))
//           .thenAnswer(
//         (_) async => http.Response('', 200),
//       );

//       // Act
//       final result = await dataSource.deleteProduct(tProductId);

//       // Assert
//       expect(result, equals(unit));
//     });

//     test('should throw a ServerException when the response code is not 200',
//         () async {
//       // Arrange
//       when(mockClient.delete(Uri.parse('${Urls.productBaseUrl}/$tProductId'),
//               headers: anyNamed('headers')))
//           .thenAnswer(
//         (_) async => http.Response('Something went wrong', 404),
//       );

//       // Act
//       final call = dataSource.deleteProduct;

//       // Assert
//       expect(() => call(tProductId), throwsA(isA<ServerException>()));
//     });
//   });
// }
