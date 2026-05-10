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
}
