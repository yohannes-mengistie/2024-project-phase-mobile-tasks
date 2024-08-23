part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LogInEvent extends AuthenticationEvent{
  final String emial;
  final String password;
  const LogInEvent({required this.emial,required this.password});
@override
  List<Object> get props => [emial,password];
}

class SignUpEvent extends AuthenticationEvent{
  final String emial;
  final String password;
  final String name;

  const SignUpEvent({required this.emial,required this.name,required this.password});
  @override
  List<Object> get props => [emial,password,name];

}
class LogRequestedEvent extends AuthenticationEvent{
  const LogRequestedEvent();
}


class LogOutEvent extends AuthenticationEvent{
}