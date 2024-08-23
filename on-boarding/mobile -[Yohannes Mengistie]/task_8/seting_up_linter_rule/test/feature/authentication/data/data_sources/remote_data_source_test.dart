// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:seting_up_linter_rule/feature/authentication/data/data_sources/remote_data_source.dart';
// import 'package:seting_up_linter_rule/feature/authentication/data/model/user_model.dart';

// import '../../../e_commerce_app/helpers/json_reader.dart';

// class MockHttpClient extends Mock{}
// void main() {
//   late MockHttpClient mockHttpClient;
//   late RemoteDataSource authRemoteDataSource;

//   group('AuthLocalDataSource', () {
//     setUp(() {
//       mockHttpClient = MockHttpClient();
//       authRemoteDataSource = RemoteDataSourceImpl(
//         client: mockHttpClient,
//       );
//     });

//     final loginResponse = readJson('login_response.json');
//     final loginModel = UserModel(name: 'name', Email: 'Email', Password: 'Password', id: 'id');

//     group('login', () {
//       test('should return user from API', () async {
//         when(mockHttpClient.post(any, any)).thenAnswer(
//             (_) async => HttpResponse(statusCode: 201, body: loginResponse));

//         final result = await RemoteDataSource.logIn(loginModel);

//         expect(result.token, jsonDecode(loginResponse)['data']['access_token']);
//       });
//     });
//   });
// }