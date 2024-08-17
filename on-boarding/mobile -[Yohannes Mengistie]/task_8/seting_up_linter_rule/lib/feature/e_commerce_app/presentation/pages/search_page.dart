import 'package:flutter/material.dart';

import '../widgets/search_page_card.dart';

class SearchProductPage extends StatelessWidget {
  SearchProductPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Search Product')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 9, 134, 236)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and filter
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_forward,
                          color: const Color.fromARGB(255, 11, 136, 238)),
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
                    color: const Color.fromARGB(255, 79, 43, 245),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.white),
                    onPressed: () {
                      // will filter logic here
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 35),
            // Product cards
            Column(
              children: [
                ProductCard(
                  imageUrl: 'images/leatherShoe.jpg',
                  title: 'derbaye shose',
                  category: "men's shoe",
                  price: "\$ 120",
                  rating: "4.0",
                ),
                ProductCard(
                  imageUrl: 'images/leatherShoe.jpg',
                  title: '', // Empty title
                  category: '', // Empty category
                  price: '', // Empty price
                  rating: '', // Empty rating
                ),
              ],
            ),
            SizedBox(height: 16),
            // Price filter
            Text("Price:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Slider(
              value: 50,
              min: 0,
              max: 100,
              divisions: 100,
              label: "50",
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
