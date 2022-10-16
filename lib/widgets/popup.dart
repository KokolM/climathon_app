import 'package:flutter/material.dart';

class ClimathonPopup extends StatefulWidget {
  final Widget child;

  const ClimathonPopup({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<ClimathonPopup> createState() => _ClimathonPopupState();
}

class _ClimathonPopupState extends State<ClimathonPopup> {
  bool _show = false;

  _onEnter(PointerEvent event) {
    if (_show != true) {
      setState(() {
        _show = true;
      });
    }
  }

  _onExit(PointerEvent event) {
    if (_show != false) {
      setState(() {
        _show = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: Visibility(
        visible: _show,
        child: widget.child,
      ),
    );
  }
}
