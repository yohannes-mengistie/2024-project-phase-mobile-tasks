import 'package:dartz/dartz.dart';

import '../../../../core/error/fialures.dart';
import '../../data/models/product_model.dart';
import '../entities/e_commerce.dart';
import '../repository/e_commerce_repository.dart';

class InsertProduct {
  final ECommerceRepository repository;
  InsertProduct(this.repository);

  Future<Either<Fialure,void>> execute(ProductModel item){
    return repository.insertProduct(item);
  }
}