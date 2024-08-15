import 'package:dartz/dartz.dart';
import 'package:seting_up_linter_rule/core/error/fialures.dart';

class InputConverter{
  Either<Fialure,int> stringToUnsignedInteger(String str){
    try{
      final integer = int.parse(str);
      if(integer < 0) throw FormatException();
      return Right(integer);
    } on FormatException{
      return Left(InvalidInputFialure('invalied input'));
    }
    
  }

}

class InvalidInputFialure extends Fialure{
  InvalidInputFialure(super.message);

}