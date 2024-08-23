import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/models/product_model.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/presentation/bloc/e_commerce_bloc.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/presentation/pages/detail_page.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/presentation/pages/update_page.dart';

class MockECommerceBloc extends MockBloc<ECommerceEvent, ECommerceState>
    implements ECommerceBloc {}

void main() {
  late MockECommerceBloc mockECommerceBloc;

  setUpAll(() {
    mockECommerceBloc = MockECommerceBloc();
    HttpOverrides.global = null;
    registerFallbackValue(Uri.parse(
        "https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777275/images/t7j2mqmcukrogvvausqj.jpg"));
  });

  tearDown(() {
    mockECommerceBloc.close();
  });
  final testProduct = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'Description 1',
    price: 100,
    imageUrl: "https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777275/images/t7j2mqmcukrogvvausqj.jpg"
  );


  Widget _buildTestableWidget(ProductDetailPage page) {
    return BlocProvider<ECommerceBloc>(
      create: (context) => mockECommerceBloc,
      child: MaterialApp(
        home: page,
      ),
    );
  }

  testWidgets('Displays loading indicator when loading', (WidgetTester tester) async {
    when(()=>mockECommerceBloc.state).thenReturn(LoadingState());

    await tester.pumpWidget(_buildTestableWidget(ProductDetailPage(product: testProduct, productId: '1')));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Displays product details when loaded', (WidgetTester tester) async {
    when(()=>mockECommerceBloc.state).thenReturn(LoadedSingleProductState(testProduct));

    await tester.pumpWidget(_buildTestableWidget(ProductDetailPage(product: testProduct, productId: '1')));

    expect(find.text(testProduct.name), findsOneWidget);
    expect(find.text('\$${testProduct.price}'), findsOneWidget);
    expect(find.text(testProduct.description), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    await tester.pumpAndSettle();
  });

  testWidgets('Displays error message when error occurs', (WidgetTester tester) async {
    when(()=>mockECommerceBloc.state).thenReturn(ErrorState('Error loading product'));

    await tester.pumpWidget(_buildTestableWidget(ProductDetailPage(product: testProduct, productId: '1')));

    expect(find.text('Error loading product'), findsOneWidget);
  });

  testWidgets('Navigates to UpdateProductPage when update button is pressed', (WidgetTester tester) async {
    when(()=>mockECommerceBloc.state).thenReturn(LoadedSingleProductState(testProduct));

    await tester.pumpWidget(_buildTestableWidget(ProductDetailPage(product: testProduct, productId: '1')));

    await tester.tap(find.text('UPDATE'));
    await tester.pumpAndSettle();

    expect(find.byType(UpdateProductPage), findsOneWidget);
  });

}