import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_dzimbabwe_traveler/main.dart';

void main() {
  testWidgets('Traveler app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SmartDzimbabweTravelerApp());
    await tester.pumpAndSettle();

    // Verify app builds successfully
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
