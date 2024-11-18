import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_to_do_app/shared/ui/scaffold_with_app_bar.dart';

void main() {
  testWidgets('Should render scaffold with app bar correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ScaffoldWithAppBar(
          child: Container(),
        ),
      ),
    );

    expect(find.byKey(const Key('MeltingAppBar')), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(
        find.byKey(const Key('ScaffoldDecorationContainer')), findsOneWidget);

    final decoratedContainerColors = (((tester.firstWidget(
      find.byKey(const Key('ScaffoldDecorationContainer')),
    ) as Container)
                .decoration as BoxDecoration)
            .gradient as LinearGradient)
        .colors;

    final colors = [
      Color.fromARGB(255, 225, 144, 255),
      Color.fromARGB(255, 166, 246, 249),
      Color.fromARGB(255, 255, 175, 177),
      Color.fromARGB(255, 255, 248, 145),
    ];

    expect(decoratedContainerColors, colors);

    expect(find.byKey(const Key('OverlayContainer')), findsOneWidget);
  });
}
