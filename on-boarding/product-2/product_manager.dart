

import 'product.dart';

class ProductManager{
    Map<String,Product> listOfProduct = {};

    // adding the new product function
    void addProduct(String name , String Description , double price){
      listOfProduct[name] = Product(name,Description,price);
    }

    // seeing all the products
    void ViewAllProduct(){
      if (listOfProduct.isEmpty){
        print("There is no product !!");
        return ;
      }

      listOfProduct.forEach((key, value) {
      print( value);
  });
    }

    void ViewSingleProduct(String name){
      if (listOfProduct.containsKey(name)){
        print(listOfProduct[name]);
        
      }
      else{
          print("product with this name does't exist");
      }
      
    }

    void editProduct(String name ,String newName , String newDescription , double newPrice){
        if (!listOfProduct.containsKey(name)){
          print("product with this name does't exist"); 
      }
      deleteProduct( name);
      addProduct(newName, newDescription, newPrice);
    }

    void deleteProduct(String name){
        if (listOfProduct.containsKey(name)){
          listOfProduct.remove(name);
        }else{
          print("product with this name does not exist");
        }
        
    }

  






}

