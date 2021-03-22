import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  const CreateButton({
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
      child: Text('FINISH'),
      onPressed: onPressed,
    );
  }
}
