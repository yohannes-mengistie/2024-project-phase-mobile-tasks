import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/presentation/widgets/search_page_card.dart';



void main() {
  testWidgets('Displays product information correctly', (WidgetTester tester) async {
    // Arrange
    const imageUrl = "";
    const title = 'Test Product';
    const category = 'Electronics';
    const price = '\$99.99';
    const rating = '4.5';

    // Act
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ProductCard(
          imageUrl: imageUrl,
          title: title,
          category: category,
          price: price,
          rating: rating,
        ),
      ),
    ));

    // Assert
    expect(find.byType(ProductCard), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.text(title), findsOneWidget);
    expect(find.text(category!), findsOneWidget);
    expect(find.text(price!), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is Icon && widget.icon == Icons.star), findsOneWidget);
    expect(find.text(rating!), findsOneWidget);
  });

  testWidgets('Displays placeholder when imageUrl is empty', (WidgetTester tester) async {
    // Arrange
    const title = 'Test Product';
    const category = 'Electronics';
    const price = '\$99.99';
    const rating = '4.5';

    // Act
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ProductCard(
          imageUrl: '',
          title: title,
          category: category,
          price: price,
          rating: rating,
        ),
      ),
    ));

    // Assert
    expect(find.byType(ProductCard), findsOneWidget);
    expect(find.byType(Placeholder), findsOneWidget); // Ensure that Placeholder is shown
    expect(find.text(title), findsOneWidget);
    expect(find.text(category!), findsOneWidget);
    expect(find.text(price!), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is Icon && widget.icon == Icons.star), findsOneWidget);
    expect(find.text(rating!), findsOneWidget);
  });
}
