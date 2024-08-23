part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();
  
  @override
  List<Object?> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class AuthenticationLoading extends AuthenticationState{
  const AuthenticationLoading();
}

class AuthenticationAuthenticated extends AuthenticationState {
  final UserModel user;
  final String? token;

  const AuthenticationAuthenticated({required this.token, required this.user});

  @override
  List<Object?> get props => [token, user];
}

class AuthenticationUnAuthenticated extends AuthenticationState{
  const AuthenticationUnAuthenticated();
}

class AuthenticationError extends AuthenticationState{
  final String message;

  const AuthenticationError({required this.message});
  @override
  List<Object> get props=> [message];
}

class AuthLoadSuccess extends AuthenticationState {
  final UserModel user;

  const AuthLoadSuccess(this.user);
}