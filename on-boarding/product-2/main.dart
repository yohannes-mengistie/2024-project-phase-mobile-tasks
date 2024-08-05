import 'dart:io';
import "product_manager.dart";

void main() {
  ProductManager productManager = ProductManager();
  while (true) {
    print('''\n--- eCommerce Application ---
1. Add Product
2. View All Products
3. View Product
4. Edit Product
5. Delete Product
6. Exit
Choose an option: ''');
    var choose = stdin.readLineSync();
    int? choice = int.parse(choose!);

    switch (choice) {
      case 1:
        print('Enter product name:');
        String name = stdin.readLineSync() ?? '';
        print('Enter product description:');
        String description = stdin.readLineSync() ?? '';
        print('Enter product price:');
        var price = stdin.readLineSync() ?? '';
        if (double.tryParse(price) == null){
          print('invalid price format');
          break;
        }
        double p = double.parse(price);
                productManager.addProduct(name, description, p);
        
      case 2:
        productManager.ViewAllProduct();
        
      case 3:
        print('Enter product name:');
        String? name = stdin.readLineSync() ;
        productManager.ViewSingleProduct(name!);
        
      case 4:
        print('Enter product name to be edit:');
        String? name = stdin.readLineSync() ;
        print('Enter new product name:');
        String newName = stdin.readLineSync() ?? '';
        print('Enter new product description:');
        String newDescription = stdin.readLineSync() ?? '';
        print('Enter new product price:');
        var newPrice = stdin.readLineSync() ?? '';
        if (double.tryParse(newPrice) == null){
          print('invalid price format');
          break;
        }
        productManager.editProduct(name!, newName, newDescription, double.parse(newPrice));
        
      case 5:
        print('Enter product name:');
        String? name = stdin.readLineSync() ;
        productManager.deleteProduct(name!);
       
      case 6:
        exit(0);
      default:
        print('Invalid option. Please try again.');
    }
  }
}
