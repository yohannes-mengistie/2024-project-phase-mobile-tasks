import 'package:dartz/dartz.dart';

import '../../../../core/error/fialures.dart';
import '../../data/model/user_model.dart';
import '../repository/authentication_repository.dart';

class GetCurrentUser{
  final AuthenticationRepository repository;

  GetCurrentUser(this.repository);

  Future<Either<Fialure,UserModel>> call(UserModel user)async{
    return await repository.getCurrentUser();
  }
}