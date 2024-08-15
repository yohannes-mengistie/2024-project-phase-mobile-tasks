import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seting_up_linter_rule/core/utils/input_converter.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInteger', () {
    test('should return an integer when the string represents an unsigned integer', () {
      final str = '121';
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result, Right(121));
    });

    test('should return a failure when the string is not an integer', () {
      final str = 'abc';
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFialure('invalied input')));
    });

    test('should return a failure when the input is less than zero', () {
      final str = '-123';
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFialure('invalied input')));
    });
  });
}
