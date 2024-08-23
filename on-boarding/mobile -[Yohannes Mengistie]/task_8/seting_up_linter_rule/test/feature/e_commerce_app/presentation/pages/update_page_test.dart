import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/models/product_model.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/entities/e_commerce.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/presentation/bloc/e_commerce_bloc.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/presentation/pages/update_page.dart';



// Mock Classes
class MockECommerceBloc extends Mock implements ECommerceBloc {}
void main() {
  late MockECommerceBloc mockECommerceBloc;
  late Product testProduct;

  setUp(() {
    mockECommerceBloc = MockECommerceBloc();
    testProduct = ProductModel(
      id: '1',
      name: 'Test Product',
      price: 100.0,
      description: 'Test Description',
      imageUrl: "https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777275/images/t7j2mqmcukrogvvausqj.jpg",
    );
    HttpOverrides.global = null;
    registerFallbackValue(Uri.parse(
        "https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777275/images/t7j2mqmcukrogvvausqj.jpg"));
  });

  Widget _buildTestableWidget(Widget child) {
    return BlocProvider<ECommerceBloc>.value(
      value: mockECommerceBloc,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('renders with initial product data', (WidgetTester tester) async {
    await tester.pumpWidget(_buildTestableWidget(UpdateProductPage(product: testProduct)));

    expect(find.text('Update Product'), findsOneWidget);
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('100.0'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
    // Add more checks for initial state if needed
  });


  testWidgets('triggers update event and navigates back when update button is pressed', (WidgetTester tester) async {
    await tester.pumpWidget(_buildTestableWidget(UpdateProductPage(product: testProduct)));

    // Enter new values
    await tester.enterText(find.byType(TextField).at(0), 'Updated Product');
    await tester.enterText(find.byType(TextField).at(1), '200.0');
    await tester.enterText(find.byType(TextField).at(2), 'Updated Description');

    // Tap the update button
    await tester.tap(find.text('UPDATE'));
    await tester.pumpAndSettle();

    // Verify that UpdateProductEvent was called
    verifyNever(() => mockECommerceBloc.add(UpdateProductEvent(testProduct.id, ProductModel(
      id: '1',
      name: 'Updated Product',
      price: 200.0,
      description: 'Updated Description',
      imageUrl: "https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777275/images/t7j2mqmcukrogvvausqj.jpg",
    )))).called(1);

    // Confirm navigation
    expect(find.byType(UpdateProductPage), findsNothing);
  });

  testWidgets('shows snackbar when form is incomplete', (WidgetTester tester) async {
    await tester.pumpWidget(_buildTestableWidget(UpdateProductPage(product: testProduct)));

    // Tap the update button without filling in the fields
    await tester.tap(find.text('UPDATE'));
    await tester.pump();

    // Check for snackbar message
    expect(find.text('Please fill in all the required fields.'), findsOneWidget);
  });
}
