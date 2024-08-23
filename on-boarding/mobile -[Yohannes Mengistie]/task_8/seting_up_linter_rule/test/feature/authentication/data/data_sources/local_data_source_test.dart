import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:seting_up_linter_rule/core/error/exceptions.dart';
import 'package:seting_up_linter_rule/feature/authentication/data/data_sources/local_data_source.dart';
import 'package:seting_up_linter_rule/feature/authentication/data/model/user_model.dart';

import '../../../e_commerce_app/helpers/test_helper.mocks.dart';

void main(){
  late LocalDataSourceImpl dataSource;
  late MockSharedPreferences sharedPreferences;

  setUp((){
    sharedPreferences = MockSharedPreferences();
    dataSource = LocalDataSourceImpl(sharedPreferences: sharedPreferences);
  });

  
  final testUser = UserModel(name: 'Test User', Email: 'test@email.com', Password: '0000', id: '1');
  final tUser = UserModel(name: 'Test User', Email: 'test@email.com', Password: '0000', id: '1',token: 'token');
  group('logInByCached', () {
    

    test(
      'should return UserModel from SharedPreferences when there is one in the cache',
      () async {
        // Arrange
        when(sharedPreferences.getString(any))
            .thenReturn(json.encode(testUser.toJson()));

        // Act
        final result = await dataSource.logInByCached();

        // Assert
        verify(sharedPreferences.getString(CACHED_USER));
        expect(result, equals(testUser));
      },
    );

    test(
      'should throw a CacheException when there is no cached value',
      () async {
        // Arrange
        when(sharedPreferences.getString(any)).thenReturn(null);

        // Act
        final call = dataSource.logInByCached;

        // Assert
        expect(() => call(), throwsA(isA<CacheException>()));
      },
    );
  });

  group('cacheUser', () {
   

    test('should call SharedPreferences to cache the data', () async {
      // Arrange
      when(sharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.cacheUser(tUser);

      // Assert
      final expectedJsonString = json.encode(tUser.toJson());
      verify(sharedPreferences.setString(
        CACHED_USER,
        expectedJsonString,
      ));
    });
  });

  group('clearCache', () {
    test('should call SharedPreferences to clear the cached data', () async {
      // Arrange
      when(sharedPreferences.remove(any))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.clearCach();

      // Assert
      verify(sharedPreferences.remove(CACHED_USER));
    });
  });

}