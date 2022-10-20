import 'package:flutter/material.dart';

class ClimathonSituationMapSelectButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const ClimathonSituationMapSelectButton({
    Key? key,
    required this.text,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primary = Theme.of(context).primaryColor;
    var subtitle = Theme.of(context).textTheme.subtitle1;
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 180,
          decoration: BoxDecoration(
              color: primary.withOpacity(selected ? 1.0 : 0.6),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              text,
              style: subtitle?.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
