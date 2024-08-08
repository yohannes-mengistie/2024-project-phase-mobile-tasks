import 'package:flutter/material.dart';

class SearchProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Product'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 9, 134, 236)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView( // Wrap the content with SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_forward, color: const Color.fromARGB(255, 11, 136, 238)),
                      hintText: "Leather",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 79, 43, 245), // Set background color to blue
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.white), // White icon
                    onPressed: () {
                      // Add filter logic here
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Directly placing the products inside a Column
            Column(
              children: [
                ProductCard(
                  imageUrl: 'images/leatherShoe.jpg', // Replace with your image URL
                  title: "Derby Leather Shoes",
                  category: "Men's shoe",
                  price: "\$120",
                  rating: "4.0",
                ),
                ProductCard(
                  imageUrl: 'images/leatherShoe.jpg', // Replace with your image URL
                  title: '', // Empty title
                  category: '', // Empty category
                  price: '', // Empty price
                  rating: '', // Empty rating
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                labelText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text("Price:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Slider(
              value: 50,
              min: 0,
              max: 100,
              divisions: 100,
              label: "50",
              onChanged: (value) {
                // Add price slider logic here
              },
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add apply filter logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 79, 43, 240),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 200),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "APPLY",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                height: 150,  // Adjust the height to your needs
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            if (title != null && title!.isNotEmpty) ...[
              SizedBox(height: 16),
              Text(
                title!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            if (category != null && category!.isNotEmpty) ...[
              SizedBox(height: 4),
              Text(
                category!,
                style: TextStyle(color: Colors.grey),
              ),
            ],
            if (price != null && price!.isNotEmpty) ...[
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  if (rating != null && rating!.isNotEmpty) ...[
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
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
