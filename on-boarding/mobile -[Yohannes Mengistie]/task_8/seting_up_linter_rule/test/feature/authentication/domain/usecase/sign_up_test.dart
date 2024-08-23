import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:seting_up_linter_rule/core/error/fialures.dart';
import 'package:seting_up_linter_rule/feature/authentication/data/model/user_model.dart';
import 'package:seting_up_linter_rule/feature/authentication/domain/entities/authentication.dart';
import 'package:seting_up_linter_rule/feature/authentication/domain/usecase/sign_up.dart';

import '../../../e_commerce_app/helpers/test_helper.mocks.dart';

void main(){
  late MockAuthenticationRepository mockAuthentication;
  late SignUpUseCase useCase;

  setUp((){
    mockAuthentication = MockAuthenticationRepository();
    useCase = SignUpUseCase(repository: mockAuthentication);
  });

  UserModel user = UserModel(name: 'Yohannes Mengistie', Email: 'yohannes@gmail.com', Password: '00000',id: '1');

  test('should return userEntites when signUp seccessful',()async{
      when(mockAuthentication.signUp(any)).thenAnswer((_) async=>Right(user));

      final result = await useCase.call(user);

      expect(result,  Right(user));
      verify(mockAuthentication.signUp(user));
  });

  test('should return failure when singUp failed',()async{
    when(mockAuthentication.signUp(any)).thenAnswer((_) async=>left(ServerFailure('signUp failure')));

    final result = await useCase.call(user);
    expect(result,left(ServerFailure('signUp failure')));
    verify(mockAuthentication.signUp(user));
  });
  
}