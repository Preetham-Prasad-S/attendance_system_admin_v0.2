import 'package:flutter_test/flutter_test.dart';

import 'package:attendance_system_admin/main.dart';

void main() {
  testWidgets('App builds without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(MyApp), findsOneWidget);
  });
}
