import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/user_model.dart';
import '../../domain/repository/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository userRepository;
  AuthenticationBloc(this.userRepository) : super(const AuthenticationInitial()) {
    on<LogInEvent>((_onLogInEvent) );
    on<SignUpEvent>((_onSignUpEvent) );
    on<LogOutEvent>((_onLogOutEvent) );
    on<LogRequestedEvent>((_onLogRequested));
  }

  Future<void> _onLogInEvent(LogInEvent event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationLoading());
    final user = UserModel(name: '', Email: event.emial, Password: event.password, id:'');
    final response = await userRepository.logIn(user);
    print('==================${response}');
    emit(response.fold(
      (failure) => AuthenticationError(message:failure.message),
      (UserModel) => AuthenticationAuthenticated(token: UserModel.token, user: user)
    ));

    // try {
    //   final user = UserModel(name: '', Email: event.emial, Password: event.password, id:'');
    //   final loginResponse = await userRepository.logIn(
    //     user
    //   );
      
      
      
    //   emit(AuthenticationAuthenticated(user: user, token: user.token));
    // } catch (e) {
    //   emit(AuthenticationError(message: e.toString()));
    // }
  }


  Future<void> _onSignUpEvent(SignUpEvent event,Emitter<AuthenticationState>emit)async{
    emit(AuthenticationLoading());

    final user = UserModel(name: event.name, Email: event.emial, Password: event.password, id:'');
    final response = await userRepository.signUp(user);
    emit(response.fold(
      (failure) => AuthenticationError(message:failure.message),
      (UserModel) => AuthenticationAuthenticated(token: UserModel.token, user: user)
    ));
  }
  
  Future<void> _onLogOutEvent(LogOutEvent event,Emitter<AuthenticationState>emit)async{
    emit(AuthenticationLoading());

    final result = await userRepository.logOut();

    emit(result.fold(
      (failure) => AuthenticationError(message: failure.message),
      (_) => AuthenticationUnAuthenticated()
    ));
  }

  Future<void> _onLogRequested(LogRequestedEvent event,Emitter<AuthenticationState>emit)async{
    emit(AuthenticationLoading());
    final response = await userRepository.getCurrentUser();
    emit(response.fold(
      (failure) => AuthenticationError(message:failure.message),
      (UserModel) => AuthLoadSuccess(UserModel)
    ));
  }
}
