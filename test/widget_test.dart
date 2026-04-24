import 'package:flutter_test/flutter_test.dart';

import 'package:anime_todo_notes_flutter/main.dart';

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AniTodoNotesApp());
    expect(find.text('Home'), findsAny);
  });
}
