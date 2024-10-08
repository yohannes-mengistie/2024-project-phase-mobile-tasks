import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/models/product_model.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/entities/e_commerce.dart';
import '../../helpers/json_reader.dart';

void main() {
  late ProductModel testProductModel;

  setUp(() {
    final String jsonString = readJson(
        'product_json.json');

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    testProductModel = ProductModel.fromJson(jsonMap);
  });

  test('should be a subclass of Product entity', () {
    expect(testProductModel, isA<Product>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is correct', () {
      // Arrange
      final result = ProductModel.fromJson(testProductModel.toJson());
      // Assert
      expect(result, testProductModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // Act
      final result = testProductModel.toJson();
      // Assert
      final expectedMap = {
      
        "id": "2",
        "name": "Test Product 2",
        "description": "Description 2",
        "price": 200,
        "imageUrl": "url2"
      
    };
      expect(result, expectedMap);
    });
  });
}
