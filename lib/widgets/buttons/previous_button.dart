import 'package:flutter/material.dart';

class PreviousButton extends StatelessWidget {
  const PreviousButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.brown.shade600,
      ),
      child: Text('PREVIOUS'),
      onPressed: onPressed,
    );
  }
}
