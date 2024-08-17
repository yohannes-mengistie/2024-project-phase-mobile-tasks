import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/e_commerce.dart';
import '../bloc/e_commerce_bloc.dart';
import 'update_page.dart';

class ProductDetailPage extends StatelessWidget {
  Product product;
  final String productId;
  ProductDetailPage(
      {super.key, required this.product, required this.productId});

  @override
  Widget build(BuildContext context) {
    context.read<ECommerceBloc>().add(GetSingleProductEvent(productId));
    return Scaffold(body:
        BlocBuilder<ECommerceBloc, ECommerceState>(builder: (context, state) {
      if (state is LoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is LoadedSingleProductState) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: Image.network(
                      product.imageUrl,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: const Color.fromARGB(255, 79, 43, 240),
                        ),
                        onPressed: () {
                          context
                              .read<ECommerceBloc>()
                              .add(const LoadAllProductEvent());
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$" + product.price.toString(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Size:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 18.0),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (var size in [39, 40, 41, 42, 43, 44])
                                  Padding(
                                    padding: const EdgeInsets.only(right: 30.0),
                                    child: ChoiceChip(
                                      label: Text(
                                        size.toString(),
                                        style: TextStyle(
                                          color: size == 41
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      selected: size == 41,
                                      selectedColor: const Color.fromARGB(
                                          255, 79, 43, 240),
                                      onSelected: (bool selected) {},
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            context.read<ECommerceBloc>().add(DeleteProductEvent(product.id.toString()));
                                
                            await Future.delayed(const Duration(seconds: 1));
                            context
                                .read<ECommerceBloc>()
                                .add(const LoadAllProductEvent());
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.red),
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "DELETE",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateProductPage(
                                          product: product,
                                        )));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 79, 43, 240),
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "UPDATE",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else if (state is ErrorState) {
        return Center(
          child: Text(state.message),
        );
      } else {
        return const Center(child: Text('No Product Found'));
      }
    }));
  }
}
