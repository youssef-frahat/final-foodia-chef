import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodia_chef/core/routes/app_router.dart';
import 'package:foodia_chef/fodiaa.dart';
import 'package:foodia_chef/core/routes/routes.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      Foodia(
        initialRoute: Routes.login,
      ),
    );

    // في حال كنت تختبر واجهة فيها زر + وعدد
    // لازم تتأكد إنها موجودة في الصفحة المبدئية

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
