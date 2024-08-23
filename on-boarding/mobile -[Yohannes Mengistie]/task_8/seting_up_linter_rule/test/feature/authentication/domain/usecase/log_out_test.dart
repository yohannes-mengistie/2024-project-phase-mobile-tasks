import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:seting_up_linter_rule/core/error/fialures.dart';
import 'package:seting_up_linter_rule/feature/authentication/domain/repository/authentication_repository.dart';
import 'package:seting_up_linter_rule/feature/authentication/domain/usecase/log_out.dart';

import '../../../e_commerce_app/helpers/test_helper.mocks.dart';

void main (){
  late MockAuthenticationRepository mockAuthentication;
  late LogOutUseCase useCase;

  setUp((){
    mockAuthentication = MockAuthenticationRepository();
    useCase = LogOutUseCase(repository: mockAuthentication);
  });

  test('should return void when logout seccessful', ()async{
    when(mockAuthentication.logOut()).thenAnswer((_) async => const Right(null));

    final result = await useCase.call();

    expect(result, const Right(null));
    verify(mockAuthentication.logOut());
    
  });

  test('should return Failure when logout fail',()async{
    when(mockAuthentication.logOut()).thenAnswer((_) async => left(ServerFailure('logOut failer')));

    final result = await useCase.call();
    expect(result, left(ServerFailure('logOut failer')));
    verify(mockAuthentication.logOut());
  });
}