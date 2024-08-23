import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';
import '../../domain/entities/e_commerce.dart';
import '../pages/detail_page.dart';

class HomeProductCard extends StatelessWidget {
  final Product data;

  const HomeProductCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    String reserve;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                            product: data,
                            productId: data.id,
                          )));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              child: data.imageUrl == ""
                  ? Placeholder()
                  : Image.network(
                      data.imageUrl,
                      width: double.infinity,
                      height: 450,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        data.name,
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Text(
                      reserve = "\$" + data.price.toString(),
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        Text("(4.0)"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
