import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seting_up_linter_rule/core/error/exceptions.dart';
import 'package:seting_up_linter_rule/core/error/fialures.dart';
import 'package:seting_up_linter_rule/core/error/network/network_info.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/data_sources/product_local_data_source.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/data_sources/product_remote_data_source.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/repositories/product_repository_impl.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/entities/e_commerce.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late ProductRepositoryImpl repository;
  late MockProductRemoteDataSource mockRemoteDataSource;
  late MockProductLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockLocalDataSource = MockProductLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tProductModelList = [
    Product(
        id: 1,
        name: 'Test Product 1',
        category: 'men',
        description: 'Description 1',
        price: 100,
        imageUrl: 'url1'),
    Product(
        id: 2,
        name: 'Test Product 2',
        category: 'women',
        description: 'Description 2',
        price: 200,
        imageUrl: 'url2'),
  ];

  final testProduct = Product(
      category: 'men shoe',
      description: 'Description 2',
      id: 3,
      imageUrl: 'url3',
      name: 'test product 3',
      price: 300);

  final testProductEntity = Product(
      id: 4,
      name: 'Test Pineapple',
      description: 'A yellow pineapple for the summer',
      category: 'for all',
      imageUrl: 'pineapple.jpg',
      price: 5.33);

  final testProductId = 5;

  void runTestOnLine(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffLine(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

// getAllProduct test
  group('getAllProduct', () {
    runTestOnLine(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockLocalDataSource.cacheProducts(tProductModelList))
            .thenAnswer((_) async => unit);
        when(mockRemoteDataSource.getAllProduct())
            .thenAnswer((_) async => tProductModelList);
        // act
        final result = await repository.getAllProduct();
        // assert
        verify(mockRemoteDataSource.getAllProduct());
        expect(result, equals(Right(tProductModelList)));
      });
    });

    runTestOnLine(() {
      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockLocalDataSource.cacheProducts(tProductModelList))
            .thenAnswer((_) async => unit);
        when(mockRemoteDataSource.getAllProduct())
            .thenAnswer((_) async => tProductModelList);

        // act
        await repository.getAllProduct();
        // assert

        verify(mockLocalDataSource.cacheProducts(tProductModelList));
      });
    });

    runTestOnLine(() {
      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getAllProduct()).thenThrow(ServerException());
        // act
        final result = await repository.getAllProduct();
        // assert
        verify(mockRemoteDataSource.getAllProduct());
        expect(
            result,
            equals(
                Left(ServerFailure('Failed to fetch products from server.'))));
      });
    });
    runTestOffLine(() {
      test('should return locally cached data when the cached data is present',
          () async {
        // arrange
        when(mockLocalDataSource.getCachedProducts())
            .thenAnswer((_) async => tProductModelList);
        // act
        final result = await repository.getAllProduct();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getCachedProducts());
        expect(result, equals(Right(tProductModelList)));
      });
    });

    runTestOffLine(() {
      test('should return CacheFailure when there is no cached data present',
          () async {
        // arrange
        when(mockLocalDataSource.getCachedProducts())
            .thenThrow(CacheException());
        // act
        final result = await repository.getAllProduct();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getCachedProducts());
        expect(result,
            equals(Left(CacheFailure('No products available in cache.'))));
      });
    });
  });

// delete product by id test
  group('delete product by id', () {
    runTestOnLine(() {
      test(
          'should delete product from remote and local data source when online',
          () async {
        // arrange

        when(mockRemoteDataSource.getProductById(any))
            .thenAnswer((_) async => testProduct);
        when(mockRemoteDataSource.deleteProduct(any))
            .thenAnswer((_) async => unit);
        when(mockLocalDataSource.deleteCachedProduct(any))
            .thenAnswer((_) async => Future.value());

        // act
        final result = await repository.deleteProduct(testProductId);

        // assert
        verify(mockRemoteDataSource.getProductById(testProductId));
        verify(mockRemoteDataSource.deleteProduct(testProductId));
        verify(mockLocalDataSource.deleteCachedProduct(testProductId));
        expect(result, equals(Right(unit)));
      });
    });

    runTestOnLine(() {
      test(
          'should return server failure when the remote deletion throws ServerException',
          () async {
        // arrange
        when(mockRemoteDataSource.getProductById(any))
            .thenAnswer((_) async => testProduct);
        when(mockRemoteDataSource.deleteProduct(any))
            .thenThrow(ServerException());

        // act
        final result = await repository.deleteProduct(testProductId);

        // assert
        verify(mockRemoteDataSource.getProductById(testProductId));
        verify(mockRemoteDataSource.deleteProduct(testProductId));
        verifyNever(mockLocalDataSource.deleteCachedProduct(testProductId));
        expect(
            result,
            equals(
                Left(ServerFailure('Failed to delete product from server.'))));
      });
    });
    runTestOffLine(() {
      test('should return server failure when there is no internet connection',
          () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        // act
        final result = await repository.deleteProduct(testProductId);

        // assert
        verifyNever(mockRemoteDataSource.getProductById(testProductId));
        verifyNever(mockRemoteDataSource.deleteProduct(testProductId));
        verifyNever(mockLocalDataSource.deleteCachedProduct(testProductId));
        expect(result, equals(Left(ServerFailure('No internet connection.'))));
      });
    });
  });

  // insertProduct test
  group('insertProduct', () {
    test(
        'should return the inserted product when the call to remote data source is successful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.insertProduct(testProductEntity))
          .thenAnswer((_) async => testProductEntity);
      // act
      final result = await repository.insertProduct(testProductEntity);
      // assert
      verify(mockRemoteDataSource.insertProduct(testProductEntity));
      expect(result, Right(testProductEntity));
    });

    test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.insertProduct(testProductEntity))
          .thenThrow(ServerException());
      // act
      final result = await repository.insertProduct(testProductEntity);
      // assert
      verify(mockRemoteDataSource.insertProduct(testProductEntity));
      expect(
          result, Left(ServerFailure('Failed to insert product to server.')));
    });
  });

// update product test
  group('updateProduct', () {
    test(
        'should return the updated product when the call to remote data source is successful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.updateProduct(testProduct))
          .thenAnswer((_) async => testProduct);
      // act
      final result = await repository.updateProduct(testProduct);
      // assert
      verify(mockRemoteDataSource.updateProduct(testProduct));
      expect(result, Right(testProduct));
    });

    test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.updateProduct(testProduct))
          .thenThrow(ServerException());
      // act
      final result = await repository.updateProduct(testProduct);
      // assert
      verify(mockRemoteDataSource.updateProduct(testProduct));
      expect(
          result, Left(ServerFailure('Failed to update product on server.')));
    });
  });

// getProductById
  group('get product by id', () {
    test(
        'should return the product when the call to remote data source is successful',
        () async {
      //arange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getProductById(testProductId))
          .thenAnswer((_) async => testProduct);
      //act
      final result = await repository.getProductById(testProductId);

      //assert

      verify(mockRemoteDataSource.getProductById(testProductId));
      expect(result, Right(testProduct));
    });
    test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getProductById(testProductId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getProductById(testProductId);
      // assert
      verify(mockRemoteDataSource.getProductById(testProductId));
      expect(
          result, Left(ServerFailure('Failed to fetch products from server.')));
    });
  });
}
