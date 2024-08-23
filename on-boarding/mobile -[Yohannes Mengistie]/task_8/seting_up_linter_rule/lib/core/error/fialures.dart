import 'package:equatable/equatable.dart';

abstract class Fialure extends Equatable {
  final String message;
  const Fialure(this.message);

  List<Object> get props => [message];
}

class CreateProductFailure extends Fialure {
  const CreateProductFailure(String message) : super(message);
}
// General Failure

class ServerFailure extends Fialure {
  ServerFailure(super.message);
}

class CacheFailure extends Fialure {
  CacheFailure(super.message);
}

class ConnectionFailure extends Fialure {
  ConnectionFailure(super.message);
}

class AuthFailure extends Fialure{
  const AuthFailure(super.message);

  factory AuthFailure.passwordTooShort() {
    return const AuthFailure('Password is too short');
  }

  factory AuthFailure.emailAlreadyInUse() {
    return const AuthFailure('Email is already in use');
  }

  factory AuthFailure.invalidEmailAndPasswordCombination() {
    return const AuthFailure('Invalid email and password combination');
  }

  factory AuthFailure.tokenExpired() {
    return const AuthFailure('Token has expired');
  }
}
