import 'package:flutter/material.dart';

//Next buttom
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200, 
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(22, 42, 58, 1), 
          foregroundColor: Colors.white, 
          padding: const EdgeInsets.symmetric(vertical: 15), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), 
          ),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}