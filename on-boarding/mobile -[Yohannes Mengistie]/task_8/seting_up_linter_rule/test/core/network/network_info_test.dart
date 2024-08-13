import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seting_up_linter_rule/core/error/network/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../feature/e_commerce_app/helpers/test_helper.mocks.dart';


void main(){
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp((){
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('isConnected',(){
    test('should forward the call to DataConnectionChecker.hasConnection', () async{
      //arrange

      final tHasConnectionFuture = Future.value(true);

      when(mockInternetConnectionChecker.hasConnection).thenAnswer((_) => tHasConnectionFuture);
      //act
      final result =  networkInfo.isConnected;
      //assert
      verify(mockInternetConnectionChecker.hasConnection);
      expect(result, tHasConnectionFuture);
    });
  });
}