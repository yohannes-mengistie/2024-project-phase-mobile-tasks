import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String? title;
  final String? category;
  final String? price;
  final String? rating;

  ProductCard({
    required this.imageUrl,
    this.title,
    this.category,
    this.price,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: imageUrl == ''
                      ? Placeholder()
                      : Image.asset(
                          imageUrl,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (category != null && category!.isNotEmpty)
                      Text(
                        category!,
                        style: TextStyle(color: Colors.grey),
                      ),
                    if (price != null && price!.isNotEmpty)
                      Text(
                        price!,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (title != null && title!.isNotEmpty)
                      Expanded(
                        child: Text(
                          title!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (rating != null && rating!.isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 16,
                          ),
                          Text(rating!),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
