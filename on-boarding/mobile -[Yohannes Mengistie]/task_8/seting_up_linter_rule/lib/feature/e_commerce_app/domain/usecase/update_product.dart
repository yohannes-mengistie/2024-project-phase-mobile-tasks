import 'package:dartz/dartz.dart';

import '../../../../core/error/fialures.dart';
import '../../data/models/product_model.dart';
import '../entities/e_commerce.dart';
import '../repository/e_commerce_repository.dart';

class UpdateProduct {
  final ECommerceRepository repository;
  UpdateProduct(this.repository);

  Future<Either<Fialure,ProductModel>> execute(ProductModel item){
    return repository.updateProduct(item);
  }
}