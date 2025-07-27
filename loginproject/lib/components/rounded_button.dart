import 'package:flutter/material.dart';
import 'package:loginproject/constant/app_text_style.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final Future<void> Function()? press; // Artık async fonksiyonları destekler

  const RoundedButton({
    super.key,
    required this.text,
    required this.color,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: TextButton(
          onPressed: press == null ? null : () => press!(), // Async fonksiyonu çağırır
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            backgroundColor: color,
          ),
          child: Text(
            text,
            style: AppTextStyle.MIDDLE_BUTTON_TEXT,
          ),
        ),
      ),
    );
  }
}
