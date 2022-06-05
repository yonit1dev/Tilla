import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tilla_team/ui/pages/global/homepage.dart';

void main() {
  testWidgets('Splash Page Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(),
      ),
    );
    expect(find.byType(ListView), findsOneWidget);
  });
}
