import 'package:dartz/dartz.dart';
import 'package:seting_up_linter_rule/core/error/fialures.dart';

import '../../data/models/product_model.dart';
import '../entities/e_commerce.dart';


abstract class ECommerceRepository{
    Future<Either<Fialure,ProductModel>>updateProduct(ProductModel product);
    Future<Either<Fialure,ProductModel>>insertProduct(ProductModel product);
    Future<Either<Fialure,Unit>> deleteProduct(String id);
    Future<Either<Fialure,List<ProductModel>>>getAllProduct();
    Future<Either<Fialure,ProductModel>>getProductById(String id);
    
}
