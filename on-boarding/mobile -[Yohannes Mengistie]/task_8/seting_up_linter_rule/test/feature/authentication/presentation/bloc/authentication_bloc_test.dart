import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:seting_up_linter_rule/core/error/fialures.dart';
import 'package:seting_up_linter_rule/feature/authentication/data/model/user_model.dart';
import 'package:seting_up_linter_rule/feature/authentication/domain/repository/authentication_repository.dart';
import 'package:seting_up_linter_rule/feature/authentication/presentation/bloc/authentication_bloc.dart';


// Mock classes
class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}

class FakeUserModel extends Fake implements UserModel {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late MockAuthenticationRepository mockAuthenticationRepository;
  setUpAll((){
    registerFallbackValue(FakeUserModel());
  });

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    authenticationBloc = AuthenticationBloc(mockAuthenticationRepository);
  });

  tearDown(() {
    authenticationBloc.close();
  });

  group('AuthenticationBloc Tests', () {
    const String tEmail = 'test@example.com';
    const String tPassword = 'password';
    const String tName = 'Test User';
    const String tToken = 'fakeToken';

    final UserModel tUser = UserModel(name: tName, Email: tEmail, Password: tPassword, id: '');
    final UserModel testUser = UserModel(name: '', Email: tEmail, Password: tPassword, id: '');

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoading, AuthenticationAuthenticated] when LogInEvent is successful',
      build: () {
        when(() => mockAuthenticationRepository.logIn(any()))
            .thenAnswer((_) async => Right(testUser.copyWith(token: tToken)));
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(LogInEvent(emial: tEmail, password: tPassword)),
      expect: () => [
        const AuthenticationLoading(),
        AuthenticationAuthenticated(user: testUser.copyWith(token: tToken), token: tToken),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoading, AuthenticationError] when LogInEvent fails',
      build: () {
        when(() => mockAuthenticationRepository.logIn(any()))
            .thenAnswer((_) async => Left(const CreateProductFailure('Login Failed')));
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(LogInEvent(emial: tEmail, password: tPassword)),
      expect: () => [
        const AuthenticationLoading(),
        const AuthenticationError(message: 'Login Failed'),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoading, AuthenticationAuthenticated] when SignUpEvent is successful',
      build: () {
        when(() => mockAuthenticationRepository.signUp(any()))
            .thenAnswer((_) async => Right(tUser.copyWith(token: tToken)));
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(SignUpEvent(name: tName, emial: tEmail, password: tPassword)),
      expect: () => [
        const AuthenticationLoading(),
        AuthenticationAuthenticated(user: tUser.copyWith(token: tToken), token: tToken),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoading, AuthenticationError] when SignUpEvent fails',
      build: () {
        when(() => mockAuthenticationRepository.signUp(any()))
            .thenAnswer((_) async => Left(CreateProductFailure('Signup Failed')));
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(SignUpEvent(name: tName, emial: tEmail, password: tPassword)),
      expect: () => [
        const AuthenticationLoading(),
        const AuthenticationError(message: 'Signup Failed'),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoading, AuthenticationUnAuthenticated] when LogOutEvent is successful',
      build: () {
        when(() => mockAuthenticationRepository.logOut())
            .thenAnswer((_) async => const Right(null));
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(LogOutEvent()),
      expect: () => [
        const AuthenticationLoading(),
        const AuthenticationUnAuthenticated(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationLoading, AuthenticationError] when LogOutEvent fails',
      build: () {
        when(() => mockAuthenticationRepository.logOut())
            .thenAnswer((_) async => Left(CreateProductFailure('Logout Failed')));
        return authenticationBloc;
      },
      act: (bloc) => bloc.add(LogOutEvent()),
      expect: () => [
        const AuthenticationLoading(),
        const AuthenticationError(message: 'Logout Failed'),
      ],
    );
  });
}
