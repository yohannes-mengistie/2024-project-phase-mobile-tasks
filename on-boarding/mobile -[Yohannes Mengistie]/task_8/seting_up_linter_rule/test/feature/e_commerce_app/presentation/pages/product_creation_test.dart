import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/models/product_model.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/entities/e_commerce.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/presentation/bloc/e_commerce_bloc.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/presentation/pages/create_page.dart';

class MockECommerceBloc extends MockBloc<ECommerceEvent, ECommerceState>
    implements ECommerceBloc {}

void main() {
  late MockECommerceBloc mockECommerceBloc;

  setUpAll(() {
    mockECommerceBloc = MockECommerceBloc();
    registerFallbackValue(DummyECommerceEvent());
  });



  final testProduct = Product(
    id: '1',
    name: 'Test Product',
    price: 100.0,
    description: 'Test Description',
    imageUrl: '',
  );

  Widget createWidgetUnderTest() {
    return BlocProvider<ECommerceBloc>(
      create: (context) => mockECommerceBloc,
      child: MaterialApp(
        home: CreateProductPage(),
      ),
    );
  }

 testWidgets('displays "Please fill in all the required fields." when fields are empty', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Tap the ADD button
    await tester.tap(find.text('ADD'));
    await tester.pump();

    // Check for the SnackBar
    expect(find.text('Please fill in all the required fields.'), findsOneWidget);
  });

  testWidgets('displays "Product Created Successfully" when product is created', (WidgetTester tester) async {
    when(() => mockECommerceBloc.add(any())).thenReturn(null);

    await tester.pumpWidget(createWidgetUnderTest());

    // Fill the text fields
    await tester.enterText(find.byKey(const Key('namedField')), 'Test Product');
    await tester.enterText(find.byKey(const Key('priceField')), '100');
    await tester.enterText(find.byKey(const Key('descriptionField')), 'This is a test description.');

    // Tap the ADD button
    await tester.tap(find.text('ADD'));
    await tester.pump();

    // Simulate state change to LoadedSingleProductState
    mockECommerceBloc.emit(LoadedSingleProductState(ProductModel(name: 'Test Product', price: 100, description: 'This is a test description.', imageUrl: 'images/defaultImage.jpg', id: '1')));
    await tester.pump();

    // Check for the SnackBar
    expect(find.text('Product Created Successfully'), findsOneWidget);
  });

  testWidgets('displays error message when an error occurs', (WidgetTester tester) async {
    when(() => mockECommerceBloc.add(any())).thenReturn(null);

    await tester.pumpWidget(createWidgetUnderTest());

    // Fill the text fields
    await tester.enterText(find.byKey(const Key('namedField')), 'Test Product');
    await tester.enterText(find.byKey(const Key('priceField')), '100');
    await tester.enterText(find.byKey(const Key('descriptionField')), 'This is a test description.');

    // Tap the ADD button
    await tester.tap(find.text('ADD'));
    await tester.pump();

    // Simulate state change to ErrorState
    mockECommerceBloc.emit(const ErrorState('Failed to create product.'));
    await tester.pump();

    // Check for the SnackBar with error message
    expect(find.text('Error: Failed to create product.'), findsOneWidget);
  });
}