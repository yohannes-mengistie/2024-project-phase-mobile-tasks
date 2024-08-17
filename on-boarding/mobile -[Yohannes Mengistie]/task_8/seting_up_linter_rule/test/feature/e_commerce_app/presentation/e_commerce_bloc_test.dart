import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:seting_up_linter_rule/core/error/fialures.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/models/product_model.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/entities/e_commerce.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/presentation/bloc/e_commerce_bloc.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late ECommerceBloc ecommerceBloc;
  late MockECommerceRepository mockECommerceRepository;

  setUp(() {
    mockECommerceRepository = MockECommerceRepository();
    ecommerceBloc = ECommerceBloc(mockECommerceRepository);
  });

  tearDown(() {
    ecommerceBloc.close();
  });
  final tProductId = '1';
  final tProduct = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'Description 1',
    price: 100,
    imageUrl: 'url1',
  );

  final tProductList = [tProduct];

  group('ECommerceBloc', () {
    test('initial state should be EmptyState', () {
      expect(ecommerceBloc.state, equals(EmptyState()));
    });

    blocTest<ECommerceBloc, ECommerceState>(
      'emits [LoadingState, LoadedAllProductState] when LoadAllProductEvent is added and products are loaded successfully',
      build: () {
        when(mockECommerceRepository.getAllProduct())
            .thenAnswer((_) async => Right(tProductList));
        return ecommerceBloc;
      },
      act: (bloc) => bloc.add(LoadAllProductEvent()),
      expect: () => [
        const LoadingState(),
        LoadedAllProductState(tProductList),
      ],
    );

    blocTest<ECommerceBloc, ECommerceState>(
      'emits [LoadingState, ErrorState] when LoadAllProductEvent is added and loading fails',
      build: () {
        when(mockECommerceRepository.getAllProduct()).thenAnswer(
            (_) async => Left(CreateProductFailure('Failed to load products')));
        return ecommerceBloc;
      },
      act: (bloc) => bloc.add(LoadAllProductEvent()),
      expect: () => [
        const LoadingState(),
        ErrorState('Failed to load products'),
      ],
    );

    blocTest<ECommerceBloc, ECommerceState>(
      'emits [LoadingState, LoadedSingleProductState] when GetSingleProductEvent is added and product is loaded successfully',
      build: () {
        when(mockECommerceRepository.getProductById(tProductId))
            .thenAnswer((_) async => Right(tProduct));
        return ecommerceBloc;
      },
      act: (bloc) => bloc.add(GetSingleProductEvent(tProductId.toString())),
      expect: () => [
        const LoadingState(),
        LoadedSingleProductState(tProduct),
      ],
    );

    blocTest<ECommerceBloc, ECommerceState>(
      'emits [LoadingState, ErrorState] when GetSingleProductEvent is added and loading fails',
      build: () {
        when(mockECommerceRepository.getProductById(tProductId)).thenAnswer(
            (_) async =>
                Left(CreateProductFailure('Failed to loading single product')));
        return ecommerceBloc;
      },
      act: (bloc) => bloc.add(GetSingleProductEvent(tProductId.toString())),
      expect: () => [
        const LoadingState(),
        ErrorState('Failed to loading single product'),
      ],
    );

    blocTest<ECommerceBloc, ECommerceState>(
      'emits [LoadingState, LoadedSingleProductState] when CreatProductEvent is added and product is created successfully',
      build: () {
        when(mockECommerceRepository.insertProduct(any))
            .thenAnswer((_) async => Right(tProduct));
        return ecommerceBloc;
      },
      act: (bloc) => bloc.add(CreatProductEvent(tProduct)),
      expect: () => [
        const LoadingState(),
        LoadedSingleProductState(tProduct),
      ],
    );

    blocTest<ECommerceBloc, ECommerceState>(
      'emits [LoadingState, ErrorState] when CreatProductEvent is added and creation fails',
      build: () {
        when(mockECommerceRepository.insertProduct(any)).thenAnswer((_) async =>
            Left(CreateProductFailure('Failed to create product')));
        return ecommerceBloc;
      },
      act: (bloc) => bloc.add(CreatProductEvent(tProduct)),
      expect: () => [
        const LoadingState(),
        ErrorState('Failed to create product'),
      ],
    );

    blocTest<ECommerceBloc, ECommerceState>(
      'emits [LoadingState, LoadedSingleProductState] when UpdateProductEvent is added and product is updated successfully',
      build: () {
        when(mockECommerceRepository.updateProduct(any))
            .thenAnswer((_) async => Right(tProduct));
        return ecommerceBloc;
      },
      act: (bloc) =>
          bloc.add(UpdateProductEvent(tProductId.toString(), tProduct)),
      expect: () => [
        const LoadingState(),
        LoadedSingleProductState(tProduct),
      ],
    );

    blocTest<ECommerceBloc, ECommerceState>(
      'emits [LoadingState, ErrorState] when UpdateProductEvent is added and update fails',
      build: () {
        when(mockECommerceRepository.updateProduct(any)).thenAnswer((_) async =>
            Left(CreateProductFailure('Failed to update product')));
        return ecommerceBloc;
      },
      act: (bloc) =>
          bloc.add(UpdateProductEvent(tProductId.toString(), tProduct)),
      expect: () => [
        const LoadingState(),
        ErrorState('Failed to update product'),
      ],
    );

    blocTest<ECommerceBloc, ECommerceState>(
      'emits [LoadingState, EmptyState] when DeleteProductEvent is added and product is deleted successfully',
      build: () {
        when(mockECommerceRepository.deleteProduct(tProductId))
            .thenAnswer((_) async => Right(unit));
        return ecommerceBloc;
      },
      act: (bloc) => bloc.add(DeleteProductEvent(tProductId.toString())),
      expect: () => [
        const LoadingState(),
        EmptyState(),
      ],
    );

    blocTest<ECommerceBloc, ECommerceState>(
      'emits [LoadingState, ErrorState] when DeleteProductEvent is added and deletion fails',
      build: () {
        when(mockECommerceRepository.deleteProduct(tProductId)).thenAnswer(
            (_) async =>
                Left(CreateProductFailure('Failed to delete product')));
        return ecommerceBloc;
      },
      act: (bloc) => bloc.add(DeleteProductEvent(tProductId.toString())),
      expect: () => [
        const LoadingState(),
        ErrorState('Failed to delete product'),
      ],
    );
  });
}
