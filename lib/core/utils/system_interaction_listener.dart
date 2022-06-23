import 'package:flutter/material.dart';

class SystemInteractionListner extends StatelessWidget {
  final VoidCallback onInteraction;
  final Widget child;
  const SystemInteractionListner({
    Key? key,
    required this.child,
    required this.onInteraction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) => onInteraction(),
      child: Listener(
        onPointerSignal: (_) => onInteraction(),
        child: RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (_) => onInteraction(),
          child: child,
        ),
      ),
    );
  }
}
