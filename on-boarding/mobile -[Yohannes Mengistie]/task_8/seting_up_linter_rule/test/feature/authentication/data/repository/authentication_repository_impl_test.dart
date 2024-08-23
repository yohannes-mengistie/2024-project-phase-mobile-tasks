// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:seting_up_linter_rule/core/error/exceptions.dart';
// import 'package:seting_up_linter_rule/core/error/fialures.dart';
// import 'package:seting_up_linter_rule/feature/authentication/data/data_sources/local_data_source.dart';
// import 'package:seting_up_linter_rule/feature/authentication/data/data_sources/remote_data_source.dart';
// import 'package:seting_up_linter_rule/feature/authentication/data/model/user_model.dart';
// import 'package:seting_up_linter_rule/feature/authentication/data/repositories/authentication_repository_impl.dart';
// import '../../../e_commerce_app/helpers/test_helper.mocks.dart';
// import '../../../../core/error/network/http.dart';

// void main() {
//   late AuthenticationRepositoryImpl repository;
//   late MockRemoteDataSource mockRemoteDataSource;
//   late MockLocalDataSource mockLocalDataSource;
//   late MockNetworkInfo mockNetworkInfo;

//   setUp(() {
//     mockRemoteDataSource = MockRemoteDataSource();
//     mockLocalDataSource = MockLocalDataSource();
//     mockNetworkInfo = MockNetworkInfo();
//     repository = AuthenticationRepositoryImpl(
//       remoteDataSource: mockRemoteDataSource,
//       localDataSource: mockLocalDataSource,
//       networkInfo: mockNetworkInfo,
//     );
//   });

//   final tUserModel = UserModel(name: 'Test User', Email: 'test@email.com', Password: '0000', id: '1');
//   final tUser = UserModel(name: 'Test User', Email: 'test@email.com', Password: '0000', id: '1',token: 'token');


//   group('logIn', () {
//     test(
//       'should check if the device is online',
//       () async {
//         // Arrange
//         when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
//         when(mockRemoteDataSource.logIn(any))
//               .thenAnswer((_) async => tUserModel);
//         when(mockLocalDataSource.cacheUser(any)).thenAnswer((_)async => tUserModel);
//         when(mockLocalDataSource.logInByCached(any))
//               .thenAnswer((_) async => tUserModel);

//         // Act
//         repository.logIn(tUserModel);

//         // Assert
//         verify(mockNetworkInfo.isConnected);
//       },
//     );

//     group('device is online', () {
//       setUp(() {
//         when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
//       });

//       test(
//         'should return remote data when the call to remote data source is successful',
//         () async {
//           // Arrange
//           when(mockRemoteDataSource.logIn(any))
//               .thenAnswer((_) async => tUserModel);

//           // Act
//           final result = await repository.logIn(tUserModel);

//           // Assert
//           verify(mockRemoteDataSource.logIn(tUserModel));
//           expect(result, equals(Right(tUserModel)));
//         },
//       );

//       test(
//         'should cache the data locally when the call to remote data source is successful',
//         () async {
//           // Arrange
//           when(mockRemoteDataSource.logIn(any))
//               .thenAnswer((_) async => tUserModel);

//           // Act
//           await repository.logIn(tUserModel);

//           // Assert
//           verify(mockRemoteDataSource.logIn(tUserModel));
//           verify(mockLocalDataSource.cacheUser(tUserModel));
//         },
//       );

//       test(
//         'should return server failure when the call to remote data source is unsuccessful',
//         () async {
//           // Arrange
//           when(mockRemoteDataSource.logIn(any)).thenThrow(ServerException());

//           // Act
//           final result = await repository.logIn(tUserModel);

//           // Assert
//           verify(mockRemoteDataSource.logIn(tUserModel));
//           expect(result, equals(Left(ServerFailure('faild to login'))));
//         },
//       );
//     });

//     group('device is offline', () {
//       setUp(() {
//         when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
//       });

//       test(
//         'should return last locally cached data when the cached data is present',
//         () async {
//           // Arrange
//           when(mockLocalDataSource.logInByCached(any))
//               .thenAnswer((_) async => tUserModel);

//           // Act
//           final result = await repository.logIn(tUserModel);

//           // Assert
//           verifyZeroInteractions(mockRemoteDataSource);
//           verify(mockLocalDataSource.logInByCached(tUserModel));
//           expect(result, equals(Right(tUserModel)));
//         },
//       );

//       test(
//         'should return CacheFailure when there is no cached data present',
//         () async {
//           // Arrange
//           when(mockLocalDataSource.logInByCached(any))
//               .thenThrow(CacheException());

//           // Act
//           final result = await repository.logIn(tUserModel);

//           // Assert
//           verifyZeroInteractions(mockRemoteDataSource);
//           verify(mockLocalDataSource.logInByCached(tUserModel));
//           expect(result, equals(Left(CacheFailure('faild to login'))));
//         },
//       );
//     });
//   });

//   group('signUp', () {
//     test(
//       'should check if the device is online',
//       () async {
//         // Arrange
//         when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
//         when(mockRemoteDataSource.signUp(any))
//               .thenAnswer((_) async => tUserModel);
//         when(mockLocalDataSource.cacheUser(any)).thenAnswer((_)async => tUserModel);
//         when(mockLocalDataSource.logInByCached(any))
//               .thenAnswer((_) async => tUserModel);
//         // Act
//         repository.signUp(tUser);

//         // Assert
//         verify(mockNetworkInfo.isConnected);
//       },
//     );

//     group('device is online', () {
//       setUp(() {
//         when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
//       });

//       test(
//         'should return remote data when the call to remote data source is successful',
//         () async {
//           // Arrange
//           when(mockRemoteDataSource.signUp(any))
//               .thenAnswer((_) async => tUserModel);

//           // Act
//           final result = await repository.signUp(tUserModel);

//           // Assert
//           verify(mockRemoteDataSource.signUp(tUserModel));
//           expect(result, equals(Right(tUserModel)));
//         },
//       );

//       test(
//         'should cache the data locally when the call to remote data source is successful',
//         () async {
//           // Arrange
//           when(mockRemoteDataSource.signUp(any))
//               .thenAnswer((_) async => tUserModel);

//           // Act
//           await repository.signUp(tUserModel);

//           // Assert
//           verify(mockRemoteDataSource.signUp(tUserModel));
//           verify(mockLocalDataSource.cacheUser(tUserModel));
//         },
//       );

//       test(
//         'should return server failure when the call to remote data source is unsuccessful',
//         () async {
//           // Arrange
//           when(mockRemoteDataSource.signUp(any)).thenThrow(ServerException());

//           // Act
//           final result = await repository.signUp(tUserModel);

//           // Assert
//           verify(mockRemoteDataSource.signUp(tUserModel));
//           expect(result, equals(Left(ServerFailure('fialed to sigUp'))));
//         },
//       );
//     });

//     group('device is offline', () {
//       setUp(() {
//         when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
//       });

//       test(
//         'should return last locally cached data when the cached data is present',
//         () async {
//           // Arrange
//           when(mockLocalDataSource.logInByCached(any))
//               .thenAnswer((_) async => tUserModel);

//           // Act
//           final result = await repository.signUp(tUserModel);

//           // Assert
//           verifyZeroInteractions(mockRemoteDataSource);
//           verify(mockLocalDataSource.logInByCached(tUserModel));
//           expect(result, equals(Right(tUserModel)));
//         },
//       );
//     });
//   });

//   group('logOut', () {
//     test(
//       'should clear cache when logOut is called',
//       () async {
//         // Arrange
//         when(mockLocalDataSource.clearCach())
//             .thenAnswer((_) async => Future.value());

//         // Act
//         final result = await repository.logOut();

//         // Assert
//         verify(mockLocalDataSource.clearCach());
//         expect(result, equals(const Right(null)));
//       },
//     );

//     test(
//       'should return CacheFailure when clearing cache fails',
//       () async {
//         // Arrange
//         when(mockLocalDataSource.clearCach()).thenThrow(CacheException());

//         // Act
//         final result = await repository.logOut();

//         // Assert
//         verify(mockLocalDataSource.clearCach());
//         expect(result, equals(Left(CacheFailure('fialed to logOut'))));
//       },
//     );
//   });
// }