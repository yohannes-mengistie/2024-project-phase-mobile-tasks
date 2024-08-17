import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/e_commerce.dart';
import '../bloc/e_commerce_bloc.dart';
import '../widgets/home_page_card.dart';
import 'create_page.dart';
import 'detail_page.dart';
import 'search_page.dart';

class HomePage extends StatelessWidget {
  //final detail;
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    context.read<ECommerceBloc>().add(LoadAllProductEvent());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 194, 192, 192),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'July 14, 2023',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Hello, ",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  TextSpan(
                    text: "Yohannes",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {
                      print("Notification Button");
                    },
                    icon: const Icon(
                      Icons.notifications,
                      color: Color.fromARGB(221, 94, 92, 92),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 17,
                right: 10,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<ECommerceBloc, ECommerceState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedAllProductState) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Available Products",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.search, color: Colors.grey),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchProductPage()));
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final item = state.products[index];
                        return HomeProductCard(data: item);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No products found.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateProductPage()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 79, 43, 240),
      ),
    );
  }
}
