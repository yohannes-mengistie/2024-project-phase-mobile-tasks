import '../../domain/entities/e_commerce.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProduct(Product product);
  Future<void> cacheProducts(List<Product> items);
  Future<void> deleteProduct(int id);
  Future<void> deleteCachedProduct(int id);
  Future<List<Product>> getCachedProducts();
  Future<Product> getCatchedProductById(int id);
}
