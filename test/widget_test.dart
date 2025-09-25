// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:dna_task_livecoding_flutter_payments/main.dart';

void main() {
  testWidgets('Layout init test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PaymentApp());

    // Wait for the 300ms API delay to complete
    await tester.pump(const Duration(milliseconds: 300));

    // Pump one more frame to ensure UI updates are complete
    await tester.pump();

    // Verify that title appears.
    expect(find.text('Products list'), findsOneWidget);

  });
}
