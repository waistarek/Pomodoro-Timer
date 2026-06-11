import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_app/widgets/big_button.dart';

void main() {
  testWidgets('BigButton renders label and icon', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BigButton(
            label: 'Start',
            icon: Icons.play_arrow,
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('Start'), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
  });

  testWidgets('BigButton exposes semantic label', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BigButton(
            label: 'Start',
            semanticLabel: 'Start timer',
            icon: Icons.play_arrow,
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(
      tester.getSemantics(find.byType(BigButton)),
      matchesSemantics(
        label: 'Start timer',
        isButton: true,
        isEnabled: true,
        hasTapAction: true,
      ),
    );
  });
}
