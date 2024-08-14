import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/entities/e_commerce.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/usecase/delete_product.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late DeleteProduct usecase;
  late MockECommerceRepository mockEcommerceRepository;

  setUp(() {
    mockEcommerceRepository = MockECommerceRepository();
    usecase = DeleteProduct(mockEcommerceRepository);
  });
  const itemId = 1;
  Product itemsToTest = Product(
      name: 'nike',
      category: 'men',
      description: 'white',
      price: 120,
      id: 1,
      imageUrl: 'image');
  test(
    'should delete product from the repository',
    () async {
      when(mockEcommerceRepository.deleteProduct(any))
          .thenAnswer((_) async => Right(unit));

      final result = await usecase.execute(itemId);

      expect(result, const Right(unit));
      verify(mockEcommerceRepository.deleteProduct(itemId));
      verifyNoMoreInteractions(mockEcommerceRepository);
    },
  );
}
