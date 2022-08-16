import 'package:flutter/material.dart';
import 'package:hive_todo_app/constants.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AppButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 350,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: primaryColor),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
