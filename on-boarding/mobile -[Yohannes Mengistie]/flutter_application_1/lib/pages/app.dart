import 'package:flutter/material.dart';

import 'package:flutter_application_1/pages/details_page.dart';
import 'package:flutter_application_1/model/product_model';
import 'package:flutter_application_1/pages/add.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/search.dart';

class ShopeApp extends StatelessWidget {
  const ShopeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shope',
      initialRoute: '/',

      // {
      //   final Map<String, dynamic> data = (ModalRoute.of(context)?.settings.arguments) as Map<String, dynamic>;

      //   return HomePage(detail: data,);
      // },
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/search': (BuildContext context) => SearchProductPage(),
        '/update': (BuildContext context) => AddProductPage(),
        '/detail': (BuildContext context) {
          final newProduct =
              (ModalRoute.of(context)?.settings.arguments) as Product;
          return ProductDetailPage(product: newProduct);
        }
      },

      theme: ThemeData.light(useMaterial3: true),
    );
  }
}
