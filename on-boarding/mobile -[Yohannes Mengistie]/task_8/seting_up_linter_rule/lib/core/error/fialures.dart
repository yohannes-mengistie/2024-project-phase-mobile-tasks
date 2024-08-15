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
