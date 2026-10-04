import 'package:flutter_test/flutter_test.dart';
import 'package:mochi_project/main.dart';

void main() {
  testWidgets('MOCHIÉ app test', (WidgetTester tester) async {
    await tester.pumpWidget(const MochieApp());

    expect(find.text('MOCHIÉ'), findsWidgets);
  });
}