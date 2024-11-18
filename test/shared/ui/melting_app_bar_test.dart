import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_to_do_app/shared/theme/colors.dart';
import 'package:simple_to_do_app/shared/ui/melting_app_bar.dart';

void main() {
  testWidgets('Should render melting app bar correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: MeltingAppBar(),
        ),
      ),
    );

    await tester.pump();

    expect(find.byKey(const Key('DecoratedContainer')), findsOneWidget);

    final decoratedContainerColors = (((tester.firstWidget(
      find.byKey(const Key('DecoratedContainer')),
    ) as Container)
                .decoration as BoxDecoration)
            .gradient as LinearGradient)
        .colors;

    expect(decoratedContainerColors[0], AppColors.brandBrightBlue);
    expect(decoratedContainerColors[1], AppColors.brandBrightPink);

    expect(find.byKey(const Key('MeltingCustomPaint')), findsOneWidget);

    expect(find.text('TASK PLANNER'), findsOneWidget);
  });
}
