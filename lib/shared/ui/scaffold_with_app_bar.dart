import 'package:flutter/material.dart';
import 'package:simple_to_do_app/shared/theme/colors.dart';
import 'package:simple_to_do_app/shared/ui/melting_app_bar.dart';

class ScaffoldWithAppBar extends StatelessWidget {
  const ScaffoldWithAppBar({
    super.key,
    required this.child,
    this.floatingActionButton,
    this.bottomAction,
  });

  final Widget child;
  final Widget? floatingActionButton;
  final Widget? bottomAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomAction,
      appBar: MeltingAppBar(
        key: const Key('MeltingAppBar'),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            key: const Key('ScaffoldDecorationContainer'),
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 225, 144, 255),
                  Color.fromARGB(255, 166, 246, 249),
                  Color.fromARGB(255, 255, 175, 177),
                  Color.fromARGB(255, 255, 248, 145),
                ],
              ),
            ),
          ),
          Container(
            key: const Key('OverlayContainer'),
            height: double.infinity,
            width: double.infinity,
            color: AppColors.brandDarkBlue.withOpacity(0.3),
          ),
          SafeArea(
            child: child,
          )
        ],
      ),
    );
  }
}
