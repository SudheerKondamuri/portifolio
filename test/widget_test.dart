// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portifolio/pages/home_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Portfolio app loads successfully', (WidgetTester tester) async {
    // Build the HomePage directly without Firebase initialization
    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(),
      ),
    );

    // Verify that the terminal welcome message is displayed.
    expect(find.text("Welcome to Sudheer's Terminal\n"), findsOneWidget);
    expect(find.text("Type 'help' for assistance"), findsOneWidget);
    
    // Verify that the terminal prompt is displayed.
    expect(find.text('(sudheer@kali)-[~] \$'), findsWidgets);
  });

  testWidgets('Terminal prompt accepts input', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(),
      ),
    );
    
    // Find the TextField
    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);
  });
}
