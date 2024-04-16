import 'package:flutter/material.dart';
import 'package:app_skeleton/widgets/theme_color_switch.dart';

class LogosContainers extends StatelessWidget {
  const LogosContainers(
      {super.key, required this.imageLeft, required this.imageRight});

  final Image imageLeft;
  final Image imageRight;

  @override
  Widget build(BuildContext context) {
    // Container that holds both logos for this row
    return Container(
      // Decoration to create colored border around the logo for visibility
      decoration: themeColorWhite(BorderRadius.circular(50), context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                top: 30,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              child: imageLeft,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                top: 30,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              child: imageRight,
            ),
          ),
        ],
      ),
    );
  }
}
