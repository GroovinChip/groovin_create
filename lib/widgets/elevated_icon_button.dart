import 'package:flutter/material.dart';

/// A custom ElevatedButton with a modified size made to fit icons
class ElevatedIconButton extends StatelessWidget {
  const ElevatedIconButton({
    Key? key,
    this.icon,
    this.color,
    this.onPressed,
  }) : super(key: key);

  final Widget? icon;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(36, 36),
        //primary: Color.lerp(Colors.brown.shade900, Colors.black, .1),
        primary: color ?? Colors.brown.shade800,
      ),
      child: icon,
      onPressed: onPressed,
    );
  }
}
