import 'package:flutter/material.dart';

class ClimathonSafeArea extends StatelessWidget {
  final Widget child;

  const ClimathonSafeArea({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 240),
      child: child,
    );
  }
}
