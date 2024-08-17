import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Product extends Equatable {
  final String name;
  final String description;
  final double price;
  final String id;
  final String imageUrl;

  Product(
      {required this.name,
    
      required this.description,
      required this.price,
      required this.id,
      required this.imageUrl});

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        description,
        price,
        id,
      ];
}
