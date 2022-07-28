import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;
  final void Function()? onPressed;
  const DefaultButton({
    Key? key,
    required this.text,
    required this.buttonColor,
    required this.textColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: buttonColor,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
