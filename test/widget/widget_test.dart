import 'package:flutter/material.dart';
import 'package:flutter_skeleton/models/student.dart';
import 'package:flutter_skeleton/pages/students_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Widget Tests', () {
    testWidgets('StudentRowForTest Widget Test, without animation',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: StudentRowBasicForTest(
            student: Student(
              gender: "male",
              age: 27,
              surname: "Cinar",
              name: "Can",
            ),
            isAnimated: false,
            isLiked: false,
            onPressed: (bool isLiked) {
              print('pressed, isLiked: $isLiked');
            },
          ),
        ),
      ));

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);

      await tester.tap(find.byType(IconButton));
      await tester.pump();

      // For animated widgets
      // await tester.pumpAndSettle();

      expect(find.byIcon(Icons.favorite_border), findsNothing);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('StudentRowForTest Widget Test, with animation',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: StudentRowBasicForTest(
            student: Student(
              gender: "male",
              age: 27,
              surname: "Cinar",
              name: "Can",
            ),
            isAnimated: false,
            isLiked: false,
            onPressed: (bool isLiked) {
              print('pressed, isLiked: $isLiked');
            },
          ),
        ),
      ));

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);

      await tester.tap(find.byType(IconButton));
      await tester.pump();

      // For animated widgets
      // await tester.pumpAndSettle();

      expect(find.byIcon(Icons.favorite_border), findsNothing);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });
  });
}
