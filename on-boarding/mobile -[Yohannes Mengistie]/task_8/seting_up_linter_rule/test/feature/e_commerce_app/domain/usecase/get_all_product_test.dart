import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/entities/e_commerce.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/repository/e_commerce_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/usecase/get_all_product.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetAllProduct getAllProductusecase;
  late MockECommerceRepository mockEcommerceRepository;

  setUp(() {
    mockEcommerceRepository = MockECommerceRepository();
    getAllProductusecase = GetAllProduct(mockEcommerceRepository);
  });
  Product items = Product(
      name: 'nike',
      category: 'men',
      description: 'white',
      price: 120,
      id: 1,
      imageUrl: 'image');

  test(
    'should get product  from the repository',
    () async {
      when(mockEcommerceRepository.getAllProduct())
          .thenAnswer((_) async => Right(items));

      final result = await getAllProductusecase.execute();

      expect(result, Right(items));
      verify(mockEcommerceRepository.getAllProduct());
      verifyNoMoreInteractions(mockEcommerceRepository);
    },
  );
}
