import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zaiblify/app.dart';

void main() {
  testWidgets('editor renders formatted output and accessible actions', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: EditorScreen()));

    expect(find.text('Editor'), findsOneWidget);
    expect(find.text('Copy result'), findsOneWidget);
    expect(find.byTooltip('Paste from clipboard'), findsOneWidget);
    expect(find.byTooltip('Clear text'), findsOneWidget);
    expect(find.textContaining('Hello'), findsWidgets);
  });

  testWidgets('clear action empties the editor and disables copy', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: EditorScreen()));

    await tester.tap(find.byTooltip('Clear text'));
    await tester.pump();

    expect(find.text('Your formatted result will appear here.'), findsOneWidget);
    final copyButton = tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Copy result'));
    expect(copyButton.onPressed, isNull);
  });
}
