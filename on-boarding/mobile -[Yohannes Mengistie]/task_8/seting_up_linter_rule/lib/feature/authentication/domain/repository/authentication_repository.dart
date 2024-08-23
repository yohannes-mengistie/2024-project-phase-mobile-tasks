import 'package:dartz/dartz.dart';

import '../../../../core/error/fialures.dart';
import '../../data/model/user_model.dart';
import '../entities/authentication.dart';

abstract class AuthenticationRepository {
  Future<Either<Fialure,UserModel>>signUp(UserModel user);
  Future<Either<Fialure,UserModel>>logIn(UserModel user);
  Future<Either<Fialure,void>>logOut();
  Future<Either<Fialure,UserModel>>getCurrentUser();
}