import 'package:flutter/material.dart';

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
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(50),
      ),
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
