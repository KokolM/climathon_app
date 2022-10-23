import 'package:flutter/material.dart';

class ClimathonSpinner extends StatelessWidget {
  final double size;

  const ClimathonSpinner({
    Key? key,
    this.size = 32,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
