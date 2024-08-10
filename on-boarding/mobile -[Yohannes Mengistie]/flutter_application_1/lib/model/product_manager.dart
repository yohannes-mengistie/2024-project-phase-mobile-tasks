import 'package:flutter_application_1/model/product_model';



Map<String, Product> cart = {};

class ProductManager {
  void addProduct(
      String name, String category, String description, String price) {
    Product product = Product(name: "", category: "", price: 0, description: "", image: 'images/leatherShoe.jpg',id:0);
    cart[name] = (product);
  }

  void viewAllProduct() {
    if (cart.isEmpty) {
    } else {
      cart.forEach((key, product) {});
    }
  }

  void viewSingleProduct(String name) {
    if (cart.containsKey(name)) {
    } else {}
  }

  void editProduct(String name, String newName, String newCategory,
      String newDescription, String newPrice) {
    if (!cart.containsKey(name)) {
    } else {
      String curName = newName;
      String curCategory = newCategory;
      String curDescription = newDescription;
      String curPrice = newPrice;

      cart.remove(name);
      addProduct(curName, curCategory, curDescription, curPrice);
    }
  }

  void deleteProdudct(String name) {
    if (cart.containsKey(name)) {
      cart.remove(name);
    } else {}
  }
}

ProductManager cartManager = ProductManager();