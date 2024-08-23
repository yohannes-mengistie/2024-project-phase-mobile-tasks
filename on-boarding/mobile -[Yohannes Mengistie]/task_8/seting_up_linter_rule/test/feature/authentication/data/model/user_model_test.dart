import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:seting_up_linter_rule/feature/authentication/data/model/user_model.dart';
import 'package:seting_up_linter_rule/feature/authentication/domain/entities/authentication.dart';

import '../../../e_commerce_app/helpers/json_reader.dart';

void main(){
  late UserModel testUserModel;

  setUp((){
    final String jsonString = readJson('register_json.json');
    final Map<String,dynamic> jsonMap = jsonDecode(jsonString)['data'];
    testUserModel = UserModel.fromJson(jsonMap);
  });

  test('shuld be the subclass of userEntities',(){
    expect(testUserModel, isA<UserEntities>());
  });
group('fromJson', (){
  
  test('should return UserEntitie from json',(){
    final result = UserModel.fromJson(testUserModel.toJson());

    expect(result, testUserModel);
  });
});

group('toJson', (){
  
  test('should return json format from userEntitie', (){
    final result = testUserModel.toJson();

    final testMap =  {
    "data": {
    "id": "66bde36e9bbe07fc39034cdd",
    "name": "Mr. User",
    "email": "user@gmail.com",
    "password": "userpassword",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InVzZXJAZ21haWwuY29tIiwiaWF0IjoxNzIzNzIwNTk3LCJleHAiOjE3MjQxNTI1OTd9.Mz9mIyOPHgyONb3bLvDO9N2wwF562Xb4nQnJEhtV3Fk"
  }
};
  expect(result,testMap['data']);
  });
});
}