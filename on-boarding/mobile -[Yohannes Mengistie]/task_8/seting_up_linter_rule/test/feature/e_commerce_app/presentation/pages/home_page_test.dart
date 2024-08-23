import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/models/product_model.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/entities/e_commerce.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/presentation/bloc/e_commerce_bloc.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/presentation/pages/create_page.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/presentation/pages/home_page.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/presentation/pages/search_page.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/presentation/widgets/home_page_card.dart';
import 'package:http/http.dart' as http;

// import '../../helpers/test_helper.mocks.dart';
class MockECommerceBloc extends MockBloc<ECommerceEvent, ECommerceState>
    implements ECommerceBloc {}

class MockClient extends Mock implements http.Client {}

void main() {
  late MockECommerceBloc mockBloc;
  late MockClient mockHttpClient;

  setUpAll(() {
    mockBloc = MockECommerceBloc();
    mockHttpClient = MockClient();
    HttpOverrides.global = null;
    registerFallbackValue(Uri.parse(
        "https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777275/images/t7j2mqmcukrogvvausqj.jpg"));
  });

  Widget HomeTestWidget() {
    return BlocProvider<ECommerceBloc>(
      create: (context) => mockBloc,
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }

  final testProducts = [
    ProductModel(
        id: '1',
        name: 'Product 1',
        description: 'Description 1',
        price: 10,
        imageUrl:
            "https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777275/images/t7j2mqmcukrogvvausqj.jpg"),
    ProductModel(
        id: '2',
        name: 'Product 2',
        description: 'Description 2',
        price: 20,
        imageUrl:
            "https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777275/images/t7j2mqmcukrogvvausqj.jpg"),
  ];

  testWidgets('HomePage - LoadingState', (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(LoadingState());

    await tester.pumpWidget(HomeTestWidget());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('HomePage - LoadedAllProductState', (WidgetTester tester) async {
    when(() => mockHttpClient.get(any())).thenAnswer(
      (_) async => http.Response('{"data":"test"}', 200),
    );
    when(() => mockBloc.state).thenReturn(LoadedAllProductState(testProducts));

    await tester.pumpWidget(HomeTestWidget());
    await tester.pump();

    expect(find.text('Available Products'), findsOneWidget);
    expect(find.byType(HomeProductCard), findsNWidgets(1));
    await tester.pumpAndSettle();
  });

  testWidgets('HomePage - ErrorState', (WidgetTester tester) async {
    const errorMessage = 'Failed to load products';
    when(() => mockBloc.state).thenReturn(ErrorState(errorMessage));

    await tester.pumpWidget(HomeTestWidget());
    await tester.pump(); // Let the bloc listener react to the state

    expect(find.text(errorMessage), findsOneWidget);
  });

  testWidgets('HomePage - Navigates to CreateProductPage when FAB is pressed',
      (WidgetTester tester) async {
    when(() => mockHttpClient.get(any())).thenAnswer(
      (_) async => http.Response('{"data":"test"}', 200),
    );
    when(() => mockBloc.state).thenReturn(LoadedAllProductState(testProducts));

    await tester.pumpWidget(HomeTestWidget());
    await tester.pump(); // Let the bloc listener react to the state

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(CreateProductPage), findsOneWidget);
  });

  testWidgets(
      'HomePage - Navigates to SearchProductPage when search button is pressed',
      (WidgetTester tester) async {
    when(() => mockHttpClient.get(any())).thenAnswer(
      (_) async => http.Response('{"data":"test"}', 200),
    );
    when(() => mockBloc.state).thenReturn(LoadedAllProductState(testProducts));
    await tester.pumpWidget(HomeTestWidget());
    await tester.pump(); // Let the bloc listener react to the state

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    expect(find.byType(SearchProductPage), findsOneWidget);
  });
}
