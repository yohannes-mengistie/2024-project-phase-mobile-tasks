import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seting_up_linter_rule/core/error/exceptions.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/data_sources/product_local_data_source.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/models/product_model.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/entities/e_commerce.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  final tProductModel = ProductModel(
    id: 1,
    name: 'Test Product',
    category: 'men',
    description: 'Description 1',
    price: 100,
    imageUrl: 'url1',
  );

  final tProductModelList = [
    ProductModel(
      id: 1,
      name: 'Test Product 1',
      category: 'men',
      description: 'Description 1',
      price: 100,
      imageUrl: 'url1',
    ),
    ProductModel(
      id: 2,
      name: 'Test Product 2',
      category: 'women',
      description: 'Description 2',
      price: 200,
      imageUrl: 'url2',
    ),
  ];

  final tProductId = 1;

  // cacheProduct test
  group('cacheProduct', () {
    test('should call SharedPreferences to cache the product', () async {
      // arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      // act
      await dataSource.cacheProduct(tProductModel);
      // assert
      final expectedJsonString = json.encode(tProductModel.toJson());
      verify(mockSharedPreferences.setString(
          'CACHED_PRODUCT_${tProductModel.id}', expectedJsonString));
    });
  });

  // cacheProducts test
  group('cacheProducts', () {
    test('should call SharedPreferences to cache the list of products',
        () async {
      // arrange
      when(mockSharedPreferences.setStringList(any, any))
          .thenAnswer((_) async => true);
      // act
      await dataSource.cacheProducts(tProductModelList);
      // assert
      final expectedJsonString = json.encode(
          tProductModelList.map((product) => product.toJson()).toList());

      final decodedList = json.decode(expectedJsonString) as List<dynamic>;

      final List<String> StringList =
          decodedList.map((item) => json.encode(item)).toList();
      verify(
          mockSharedPreferences.setStringList('CACHED_PRODUCTS', StringList));
    });
  });

// getCachedProducts test
  group('getCachedProducts', () {
    test(
        'should return a list of products from SharedPreferences when there is data',
        () async {
      // arrange
      final jsonString = json.encode(
          tProductModelList.map((product) => product.toJson()).toList());
      final decodedList = json.decode(jsonString) as List<dynamic>;

      final List<String> jsonStringList =
          decodedList.map((item) => json.encode(item)).toList();
      when(mockSharedPreferences.getStringList(any)).thenReturn(jsonStringList);
      // act
      final result = await dataSource.getCachedProducts();
      // assert
      expect(result, equals(tProductModelList));
    });

    test('should throw a CacheException when there is no data', () async {
      // arrange
      when(mockSharedPreferences.getStringList(any)).thenReturn(null);
      // act
      final call = dataSource.getCachedProducts;
      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

// deleteCachedProduct test
  group('deleteCachedProduct', () {
    test('should call SharedPreferences to delete a cached product', () async {
      // arrange
      when(mockSharedPreferences.remove(any)).thenAnswer((_) async => true);
      // act
      await dataSource.deleteCachedProduct(tProductId);
      // assert
      verify(mockSharedPreferences.remove('CACHED_PRODUCT_$tProductId'));
    });
  });

// getCachedProductById test
  group('getCachedProductById', () {
    test('should return a product from SharedPreferences when there is data',
        () async {
      // arrange
      final jsonString = json.encode(tProductModel.toJson());
      when(mockSharedPreferences.getString(any)).thenReturn(jsonString);
      // act
      final result = await dataSource.getCatchedProductById(tProductModel.id);
      // assert
      expect(result, equals(tProductModel));
    });

    test('should throw a CacheException when there is no data', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = dataSource.getCatchedProductById;
      // assert
      expect(() => call(tProductModel.id), throwsA(isA<CacheException>()));
    });
  });
}
