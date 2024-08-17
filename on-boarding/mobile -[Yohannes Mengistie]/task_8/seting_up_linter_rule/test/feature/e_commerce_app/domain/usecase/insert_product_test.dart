import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/models/product_model.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/entities/e_commerce.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/repository/e_commerce_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/usecase/get_all_product.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/usecase/insert_product.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late InsertProduct insertProductusecase;
  late MockECommerceRepository mockEcommerceRepository;

  setUp(() {
    mockEcommerceRepository = MockECommerceRepository();
    insertProductusecase = InsertProduct(mockEcommerceRepository);
  });
  ProductModel items = ProductModel(
      name: 'nike',
      
      description: 'white',
      price: 120,
      id: '1',
      imageUrl: 'image');

  test(
    'should insert product  from the repository',
    () async {
      when(mockEcommerceRepository.insertProduct(items))
          .thenAnswer((_) async => Right(items));

      final result = await insertProductusecase.execute(items);

      expect(result, Right(items));
      verify(mockEcommerceRepository.insertProduct(items));
      verifyNoMoreInteractions(mockEcommerceRepository);
    },
  );
}
