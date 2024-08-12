import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/entities/e_commerce.dart';

class ProductModel extends Product {
  ProductModel({
    required String name,
    required String category,
    required String description,
    required double price,
    required int id,
    required String imageUrl,
  }) : super(
          name: name,
          category: category,
          description: description,
          price: price,
          id: id,
          imageUrl: imageUrl,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      category: json['category'],
      description: json['description'],
      price: json['price'].toDouble(),
      id: json['id'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'description': description,
      'price': price,
      'id': id,
      'imageUrl': imageUrl,
    };
  }
}
