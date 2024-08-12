import 'package:dartz/dartz.dart';

import '../../../../core/error/fialures.dart';
import '../entities/e_commerce.dart';
import '../repository/e_commerce_repository.dart';

class InsertProduct {
  final ECommerceRepository repository;
  InsertProduct(this.repository);

  Future<Either<Fialure,Product>> execute(Product item){
    return repository.insertProduct(item);
  }
}