import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/models/product_model.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/entities/e_commerce.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/presentation/bloc/e_commerce_bloc.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/presentation/pages/detail_page.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/presentation/widgets/home_page_card.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
class MockECommerceBloc extends Mock implements ECommerceBloc {}

void main() {
  late Product testProduct;
  late NavigatorObserver mockNavigatorObserver;
  late MockECommerceBloc mockECommerceBloc;

  setUpAll(() {
    mockECommerceBloc = MockECommerceBloc();
    testProduct = ProductModel(
      id: '1',
      name: 'Test Product',
      price: 100.0,
      description: 'Test Description',
      imageUrl: "https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777275/images/t7j2mqmcukrogvvausqj.jpg",
    );
    mockNavigatorObserver = MockNavigatorObserver();
    HttpOverrides.global = null;
    registerFallbackValue(Uri.parse(
        "https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777275/images/t7j2mqmcukrogvvausqj.jpg"));
  });

  Widget _buildTestableWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
      navigatorObservers: [mockNavigatorObserver],
    );
  }

   Widget _buildWidget(Widget child) {
    return BlocProvider<ECommerceBloc>.value(
      value: mockECommerceBloc,
      child: MaterialApp(
        home: child,
      ),
    );
  }


  testWidgets('Displays product information and navigates to detail page on tap', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(_buildWidget(HomeProductCard(data: testProduct)));

    // Assert product details are displayed
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('\$100.0'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget); // Ensure that the image is loaded

    // Act
    await tester.tap(find.byType(HomeProductCard));
    await tester.pumpAndSettle(); // Wait for navigation to complete

    // Assert navigation to ProductDetailPage
    verify(() => mockNavigatorObserver.didPush(any(), any())).called(1);
    expect(find.byType(ProductDetailPage), findsOneWidget);
  });

  testWidgets('Displays placeholder when imageUrl is empty', (WidgetTester tester) async {
    // Arrange with an empty imageUrl
    testProduct = ProductModel(
      id: '1',
      name: 'Test Product',
      price: 100.0,
      description: 'Test Description',
      imageUrl: '',
    );

    await tester.pumpWidget(_buildTestableWidget(HomeProductCard(data: testProduct)));

    // Assert placeholder is shown instead of image
    expect(find.byType(Placeholder), findsOneWidget);
  });
}