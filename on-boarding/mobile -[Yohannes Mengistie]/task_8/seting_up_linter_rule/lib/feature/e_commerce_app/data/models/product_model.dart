import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/entities/e_commerce.dart';

class ProductModel extends Product {
  ProductModel({
    required String name,
    required String description,
    required double price,
    required String id,
    required String imageUrl,
  }) : super(
          name: name,
          description: description,
          price: price,
          id: id,
          imageUrl: imageUrl,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      id: json['id'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'id': id,
      'imageUrl': imageUrl,
    };
  }
}
