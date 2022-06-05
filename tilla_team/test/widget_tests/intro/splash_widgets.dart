import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tilla_team/ui/pages/welcome.dart';
import 'package:tilla_team/ui/styles/monoicons.dart';

void main() {
  testWidgets('Splash Page Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: WelcomePage(),
      ),
    );
    expect(find.text("Tilla"), findsOneWidget);

    expect(find.widgetWithIcon(ElevatedButton, Icons.arrow_forward),
        findsOneWidget);
  });
}
