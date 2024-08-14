// Mocks generated by Mockito 5.4.4 from annotations
// in seting_up_linter_rule/test/feature/e_commerce_app/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:seting_up_linter_rule/core/error/fialures.dart' as _i7;
import 'package:seting_up_linter_rule/core/error/network/network_info.dart'
    as _i10;
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/data_sources/product_local_data_source.dart'
    as _i9;
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/data_sources/product_remote_data_source.dart'
    as _i8;
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/entities/e_commerce.dart'
    as _i3;
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/repository/e_commerce_repository.dart'
    as _i5;
import 'package:shared_preferences/shared_preferences.dart' as _i11;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeProduct_1 extends _i1.SmartFake implements _i3.Product {
  _FakeProduct_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUnit_2 extends _i1.SmartFake implements _i2.Unit {
  _FakeUnit_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDuration_3 extends _i1.SmartFake implements Duration {
  _FakeDuration_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAddressCheckResult_4 extends _i1.SmartFake
    implements _i4.AddressCheckResult {
  _FakeAddressCheckResult_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ECommerceRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockECommerceRepository extends _i1.Mock
    implements _i5.ECommerceRepository {
  MockECommerceRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Fialure, _i3.Product>> updateProduct(
          _i3.Product? product) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateProduct,
          [product],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Fialure, _i3.Product>>.value(
            _FakeEither_0<_i7.Fialure, _i3.Product>(
          this,
          Invocation.method(
            #updateProduct,
            [product],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Fialure, _i3.Product>>);

  @override
  _i6.Future<_i2.Either<_i7.Fialure, _i3.Product>> insertProduct(
          _i3.Product? product) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertProduct,
          [product],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Fialure, _i3.Product>>.value(
            _FakeEither_0<_i7.Fialure, _i3.Product>(
          this,
          Invocation.method(
            #insertProduct,
            [product],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Fialure, _i3.Product>>);

  @override
  _i6.Future<_i2.Either<_i7.Fialure, _i2.Unit>> deleteProduct(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteProduct,
          [id],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Fialure, _i2.Unit>>.value(
            _FakeEither_0<_i7.Fialure, _i2.Unit>(
          this,
          Invocation.method(
            #deleteProduct,
            [id],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Fialure, _i2.Unit>>);

  @override
  _i6.Future<_i2.Either<_i7.Fialure, List<_i3.Product>>> getAllProduct() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllProduct,
          [],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Fialure, List<_i3.Product>>>.value(
                _FakeEither_0<_i7.Fialure, List<_i3.Product>>(
          this,
          Invocation.method(
            #getAllProduct,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Fialure, List<_i3.Product>>>);

  @override
  _i6.Future<_i2.Either<_i7.Fialure, _i3.Product>> getProductById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getProductById,
          [id],
        ),
        returnValue: _i6.Future<_i2.Either<_i7.Fialure, _i3.Product>>.value(
            _FakeEither_0<_i7.Fialure, _i3.Product>(
          this,
          Invocation.method(
            #getProductById,
            [id],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Fialure, _i3.Product>>);
}

/// A class which mocks [ProductRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockProductRemoteDataSource extends _i1.Mock
    implements _i8.ProductRemoteDataSource {
  MockProductRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i3.Product> updateProduct(_i3.Product? product) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateProduct,
          [product],
        ),
        returnValue: _i6.Future<_i3.Product>.value(_FakeProduct_1(
          this,
          Invocation.method(
            #updateProduct,
            [product],
          ),
        )),
      ) as _i6.Future<_i3.Product>);

  @override
  _i6.Future<_i3.Product> insertProduct(_i3.Product? product) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertProduct,
          [product],
        ),
        returnValue: _i6.Future<_i3.Product>.value(_FakeProduct_1(
          this,
          Invocation.method(
            #insertProduct,
            [product],
          ),
        )),
      ) as _i6.Future<_i3.Product>);

  @override
  _i6.Future<_i2.Unit> deleteProduct(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteProduct,
          [id],
        ),
        returnValue: _i6.Future<_i2.Unit>.value(_FakeUnit_2(
          this,
          Invocation.method(
            #deleteProduct,
            [id],
          ),
        )),
      ) as _i6.Future<_i2.Unit>);

  @override
  _i6.Future<List<_i3.Product>> getAllProduct() => (super.noSuchMethod(
        Invocation.method(
          #getAllProduct,
          [],
        ),
        returnValue: _i6.Future<List<_i3.Product>>.value(<_i3.Product>[]),
      ) as _i6.Future<List<_i3.Product>>);

  @override
  _i6.Future<_i3.Product> getProductById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getProductById,
          [id],
        ),
        returnValue: _i6.Future<_i3.Product>.value(_FakeProduct_1(
          this,
          Invocation.method(
            #getProductById,
            [id],
          ),
        )),
      ) as _i6.Future<_i3.Product>);
}

/// A class which mocks [ProductLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockProductLocalDataSource extends _i1.Mock
    implements _i9.ProductLocalDataSource {
  MockProductLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<void> cacheProduct(_i3.Product? product) => (super.noSuchMethod(
        Invocation.method(
          #cacheProduct,
          [product],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> cacheProducts(List<_i3.Product>? items) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheProducts,
          [items],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> deleteProduct(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteProduct,
          [id],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> deleteCachedProduct(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteCachedProduct,
          [id],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<List<_i3.Product>> getCachedProducts() => (super.noSuchMethod(
        Invocation.method(
          #getCachedProducts,
          [],
        ),
        returnValue: _i6.Future<List<_i3.Product>>.value(<_i3.Product>[]),
      ) as _i6.Future<List<_i3.Product>>);

  @override
  _i6.Future<_i3.Product> getCatchedProductById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getCatchedProductById,
          [id],
        ),
        returnValue: _i6.Future<_i3.Product>.value(_FakeProduct_1(
          this,
          Invocation.method(
            #getCatchedProductById,
            [id],
          ),
        )),
      ) as _i6.Future<_i3.Product>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i10.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);
}

/// A class which mocks [InternetConnectionChecker].
///
/// See the documentation for Mockito's code generation for more information.
class MockInternetConnectionChecker extends _i1.Mock
    implements _i4.InternetConnectionChecker {
  MockInternetConnectionChecker() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Duration get checkInterval => (super.noSuchMethod(
        Invocation.getter(#checkInterval),
        returnValue: _FakeDuration_3(
          this,
          Invocation.getter(#checkInterval),
        ),
      ) as Duration);

  @override
  Duration get checkTimeout => (super.noSuchMethod(
        Invocation.getter(#checkTimeout),
        returnValue: _FakeDuration_3(
          this,
          Invocation.getter(#checkTimeout),
        ),
      ) as Duration);

  @override
  List<_i4.AddressCheckOptions> get addresses => (super.noSuchMethod(
        Invocation.getter(#addresses),
        returnValue: <_i4.AddressCheckOptions>[],
      ) as List<_i4.AddressCheckOptions>);

  @override
  set addresses(List<_i4.AddressCheckOptions>? value) => super.noSuchMethod(
        Invocation.setter(
          #addresses,
          value,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Future<bool> get hasConnection => (super.noSuchMethod(
        Invocation.getter(#hasConnection),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<_i4.InternetConnectionStatus> get connectionStatus =>
      (super.noSuchMethod(
        Invocation.getter(#connectionStatus),
        returnValue: _i6.Future<_i4.InternetConnectionStatus>.value(
            _i4.InternetConnectionStatus.connected),
      ) as _i6.Future<_i4.InternetConnectionStatus>);

  @override
  _i6.Stream<_i4.InternetConnectionStatus> get onStatusChange =>
      (super.noSuchMethod(
        Invocation.getter(#onStatusChange),
        returnValue: _i6.Stream<_i4.InternetConnectionStatus>.empty(),
      ) as _i6.Stream<_i4.InternetConnectionStatus>);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  bool get isActivelyChecking => (super.noSuchMethod(
        Invocation.getter(#isActivelyChecking),
        returnValue: false,
      ) as bool);

  @override
  _i6.Future<_i4.AddressCheckResult> isHostReachable(
          _i4.AddressCheckOptions? options) =>
      (super.noSuchMethod(
        Invocation.method(
          #isHostReachable,
          [options],
        ),
        returnValue:
            _i6.Future<_i4.AddressCheckResult>.value(_FakeAddressCheckResult_4(
          this,
          Invocation.method(
            #isHostReachable,
            [options],
          ),
        )),
      ) as _i6.Future<_i4.AddressCheckResult>);
}

/// A class which mocks [SharedPreferences].
///
/// See the documentation for Mockito's code generation for more information.
class MockSharedPreferences extends _i1.Mock implements _i11.SharedPreferences {
  MockSharedPreferences() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Set<String> getKeys() => (super.noSuchMethod(
        Invocation.method(
          #getKeys,
          [],
        ),
        returnValue: <String>{},
      ) as Set<String>);

  @override
  Object? get(String? key) => (super.noSuchMethod(Invocation.method(
        #get,
        [key],
      )) as Object?);

  @override
  bool? getBool(String? key) => (super.noSuchMethod(Invocation.method(
        #getBool,
        [key],
      )) as bool?);

  @override
  int? getInt(String? key) => (super.noSuchMethod(Invocation.method(
        #getInt,
        [key],
      )) as int?);

  @override
  double? getDouble(String? key) => (super.noSuchMethod(Invocation.method(
        #getDouble,
        [key],
      )) as double?);

  @override
  String? getString(String? key) => (super.noSuchMethod(Invocation.method(
        #getString,
        [key],
      )) as String?);

  @override
  bool containsKey(String? key) => (super.noSuchMethod(
        Invocation.method(
          #containsKey,
          [key],
        ),
        returnValue: false,
      ) as bool);

  @override
  List<String>? getStringList(String? key) =>
      (super.noSuchMethod(Invocation.method(
        #getStringList,
        [key],
      )) as List<String>?);

  @override
  _i6.Future<bool> setBool(
    String? key,
    bool? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setBool,
          [
            key,
            value,
          ],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<bool> setInt(
    String? key,
    int? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setInt,
          [
            key,
            value,
          ],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<bool> setDouble(
    String? key,
    double? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setDouble,
          [
            key,
            value,
          ],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<bool> setString(
    String? key,
    String? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setString,
          [
            key,
            value,
          ],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<bool> setStringList(
    String? key,
    List<String>? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setStringList,
          [
            key,
            value,
          ],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<bool> remove(String? key) => (super.noSuchMethod(
        Invocation.method(
          #remove,
          [key],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<bool> commit() => (super.noSuchMethod(
        Invocation.method(
          #commit,
          [],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<bool> clear() => (super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<void> reload() => (super.noSuchMethod(
        Invocation.method(
          #reload,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}
