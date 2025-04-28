// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:test1/main.dart';

void main() {
  testWidgets('Coffee shop app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CoffeeShopApp());

    // Verify that the app title is displayed
    expect(find.text('COFFEE HAVEN'), findsOneWidget);

    // Verify that categories section exists
    expect(find.text('Categories'), findsOneWidget);

    // Verify that featured coffees section exists
    expect(find.text('Featured Coffees'), findsOneWidget);
  });
}
