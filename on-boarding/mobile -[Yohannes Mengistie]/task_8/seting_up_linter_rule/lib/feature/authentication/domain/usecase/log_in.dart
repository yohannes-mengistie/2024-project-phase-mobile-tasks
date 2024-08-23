import 'package:dartz/dartz.dart';

import '../../../../core/error/fialures.dart';
import '../../data/model/user_model.dart';
import '../entities/authentication.dart';
import '../repository/authentication_repository.dart';

class LogInUseCase{
  final AuthenticationRepository repository;

  LogInUseCase({required this.repository});

  Future<Either<Fialure,UserModel>> call(UserModel user)async{
    return await repository.logIn(user);
  }
}