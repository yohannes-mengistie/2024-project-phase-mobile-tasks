
class Product{
  String name;
  String description;
  double price;
  Product (this.name,this.description,this.price);
  @override
  String toString() {
    return 'Product{name: $name, description: $description, price: $price}';
  }

}