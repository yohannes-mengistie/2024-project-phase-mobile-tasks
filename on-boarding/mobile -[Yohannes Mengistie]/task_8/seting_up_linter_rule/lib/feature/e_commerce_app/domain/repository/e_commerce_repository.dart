import 'package:dartz/dartz.dart';
import 'package:seting_up_linter_rule/core/error/fialures.dart';

import '../entities/e_commerce.dart';


abstract class ECommerceRepository{
    Future<Either<Fialure,Product>>updateProduct(Product product);
    Future<Either<Fialure,Product>>insertProduct(Product product);
    Future<Either<Fialure,Product>> deleteProduct(int id);
    Future<Either<Fialure,Product>>getAllProduct();
    
}
