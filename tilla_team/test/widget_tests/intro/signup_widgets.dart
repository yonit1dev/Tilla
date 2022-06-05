import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tilla_team/ui/auth/register.dart';
import 'package:tilla_team/ui/styles/buttons.dart';
import 'package:tilla_team/ui/styles/textfields.dart';

void main() {
  testWidgets('Login Page Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RegisterPage(),
      ),
    );

    expect(find.byType(NativeTextField), findsNWidgets(4));

    expect(find.byType(AffirmButtons), findsNWidgets(1));
  });
}
