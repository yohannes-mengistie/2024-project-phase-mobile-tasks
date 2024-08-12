import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/entities/e_commerce.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/repository/e_commerce_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/usecase/get_all_product.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/usecase/update_product.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late UpdateProduct updateProductusecase;
  late MockECommerceRepository mockEcommerceRepository;

  setUp(() {
    mockEcommerceRepository = MockECommerceRepository();
    updateProductusecase = UpdateProduct(mockEcommerceRepository);
  });
  Product itemsToUpdate = Product(
      name: 'nike',
      category: 'men',
      description: 'white',
      price: 120,
      id: 1,
      imageUrl: 'image');
  Product itemsToTest = Product(
      name: 'nike',
      category: 'men',
      description: 'black',
      price: 100,
      id: 2,
      imageUrl: 'image');

  test(
    'should edit product  from the repository',
    () async {
      when(mockEcommerceRepository.updateProduct(any))
          .thenAnswer((_) async => Right(itemsToUpdate));

      final result = await updateProductusecase.execute(itemsToTest);

      expect(result, Right(itemsToUpdate));
      verify(mockEcommerceRepository.updateProduct(itemsToTest));
      verifyNoMoreInteractions(mockEcommerceRepository);
    },
  );
}
