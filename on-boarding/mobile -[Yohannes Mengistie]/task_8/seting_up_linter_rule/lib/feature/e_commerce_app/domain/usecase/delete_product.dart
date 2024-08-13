import 'package:dartz/dartz.dart';
import 'package:seting_up_linter_rule/core/error/fialures.dart';

import '../entities/e_commerce.dart';
import '../repository/e_commerce_repository.dart';

class DeleteProduct {
  final ECommerceRepository repository;
  DeleteProduct(this.repository);

  Future<Either<Fialure, Unit>> execute(int id) {
    return repository.deleteProduct(id);
  }
}
