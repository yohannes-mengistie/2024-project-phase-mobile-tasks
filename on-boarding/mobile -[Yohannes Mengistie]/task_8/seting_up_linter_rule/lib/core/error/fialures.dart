import 'package:equatable/equatable.dart';

abstract class Fialure extends Equatable{
  final String message;
  const Fialure(this.message);

  List<Object> get props => [message];
  
}