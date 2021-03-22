import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Color.lerp(Colors.blue.shade800, Colors.grey.shade800, .5),
      ),
      child: Text('NEXT'),
      onPressed: onPressed,
    );
  }
}
