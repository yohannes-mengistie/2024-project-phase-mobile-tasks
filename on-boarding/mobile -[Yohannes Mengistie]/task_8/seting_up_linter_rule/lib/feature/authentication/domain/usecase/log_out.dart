import 'dart:ffi';

import 'package:dartz/dartz.dart';

import '../../../../core/error/fialures.dart';
import '../entities/authentication.dart';
import '../repository/authentication_repository.dart';

class LogOutUseCase{
  final AuthenticationRepository repository;

  LogOutUseCase({required this.repository});

  Future<Either<Fialure,void>> call()async{
    return await repository.logOut();
  }
}