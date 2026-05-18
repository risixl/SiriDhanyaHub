// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:siri_dhanya_hub/main.dart';
import 'package:siri_dhanya_hub/providers/app_provider.dart';

void main() {
  testWidgets('Siri-Dhanya app loads the home screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppProvider(),
        child: const SiriDhanyaApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Siri-Dhanya Hub'), findsOneWidget);
    expect(find.text('Quick Access'), findsOneWidget);
  });
}
