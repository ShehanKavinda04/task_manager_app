// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:task_manager_app/main.dart';

void main() {
  testWidgets('TaskMaster UI smoke test', (WidgetTester tester) async {
    // Mock SharedPreferences
    SharedPreferences.setMockInitialValues({});

    // Build our app and trigger a frame.
    await tester.pumpWidget(const TaskMasterApp());

    // Verify that our header is present.
    expect(find.text('TaskMaster'), findsOneWidget);
    
    // Verify that our empty state is present.
    expect(find.text('All Clear!'), findsOneWidget);
    expect(find.text('You have no tasks. Add one to get started.'), findsOneWidget);

    // Enter a new task
    await tester.enterText(find.byType(TextField), 'Buy milk');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle(); // Wait for animation

    // Verify task is added
    expect(find.text('Buy milk'), findsOneWidget);
    expect(find.text('All Clear!'), findsNothing);
  });
}
