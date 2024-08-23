import 'package:equatable/equatable.dart';

class UserEntities extends Equatable {
  final String name;
  final String Email;
  final String Password;
  final String id;
  final String? token;

  UserEntities(
      {required this.name, required this.Email, required this.Password,required this.id,this.token});

  @override
  List<Object?> get props => [name, Email, Password,id];
}
