import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:seting_up_linter_rule/core/error/fialures.dart';
import 'package:seting_up_linter_rule/feature/authentication/data/model/user_model.dart';
import 'package:seting_up_linter_rule/feature/authentication/domain/entities/authentication.dart';
import 'package:seting_up_linter_rule/feature/authentication/domain/usecase/log_in.dart';

import '../../../e_commerce_app/helpers/test_helper.mocks.dart';

void main(){
  late MockAuthenticationRepository mockAuthentication;
  late LogInUseCase useCase;

  setUp((){
    mockAuthentication = MockAuthenticationRepository();
    useCase = LogInUseCase(repository: mockAuthentication);
  }
  );

  UserModel user = UserModel(name: 'Yohannes Mengistie', Email: 'yohannes@gmail.com', Password: '00000',id: '1');

  test('shuld return  userentitie when login is seccessful', ()async{
      when(mockAuthentication.logIn(any)).thenAnswer((_) async=>Right(user));

      final result = await useCase.call(user);

      expect(result, Right(user));
      verify(mockAuthentication.logIn(user));
  });

  test('shuld return login Failure when unseccessful login',() async{
    when(mockAuthentication.logIn(any)).thenAnswer((_) async=>Left(ServerFailure('Login failure')));

    final result  = await useCase.call(user);
    expect(result, left(ServerFailure('Login failure')));
  });

}