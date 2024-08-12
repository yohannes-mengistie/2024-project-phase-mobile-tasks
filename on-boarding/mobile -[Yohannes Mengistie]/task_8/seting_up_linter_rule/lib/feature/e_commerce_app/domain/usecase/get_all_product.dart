import 'package:dartz/dartz.dart';

import '../../../../core/error/fialures.dart';
import '../entities/e_commerce.dart';
import '../repository/e_commerce_repository.dart';

class GetAllProduct {
  final ECommerceRepository repository;
  GetAllProduct(this.repository);

  Future<Either<Fialure,Product>> execute(){
    return repository.getAllProduct();
  }
}