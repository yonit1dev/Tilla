import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tilla_team/ui/auth/login.dart';
import 'package:tilla_team/ui/styles/buttons.dart';
import 'package:tilla_team/ui/styles/textfields.dart';

void main() {
  testWidgets('Login Page Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(),
      ),
    );

    expect(find.byType(NativeTextField), findsNWidgets(2));

    expect(find.byType(AffirmButtons), findsNWidgets(1));

    expect(find.widgetWithText(ElevatedButton, 'Login with Google'),
        findsOneWidget);
  });
}
