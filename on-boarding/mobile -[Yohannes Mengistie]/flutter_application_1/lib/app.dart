import  'package:flutter/material.dart';
import 'package:flutter_application_1/add_update_page.dart';
import 'package:flutter_application_1/details_page.dart';
import 'package:flutter_application_1/search_page.dart';

import 'home_page.dart';

class ShopeApp extends StatelessWidget {
  const ShopeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shope',
      initialRoute: '/',
  
      routes: {
        '/': (BuildContext context) => const HomePage(),
        // '/search':(BuildContext context) => SearchProductPage(),
        // '/update':(BuildContext context) => AddProductPage(),
        // '/detail':(BuildContext context) => ProductDetailPage(),
      },
      theme: ThemeData.light(useMaterial3: true),
    );
  }
}