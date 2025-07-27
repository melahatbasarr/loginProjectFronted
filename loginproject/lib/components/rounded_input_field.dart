import 'package:flutter/material.dart';
import 'package:loginproject/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChange;
  final bool isPassword;
  final IconData icon;
  final bool isEmail;
  final TextEditingController? controller; // EKLENDİ

  const RoundedInputField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.onChange,
    required this.isEmail,
    required this.isPassword,
    this.controller, // EKLENDİ
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller, // EKLENDİ
        onChanged: onChange,
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(icon, color: const Color(0xff3f3056)),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            gapPadding: 1.0,
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          fillColor: Colors.grey.shade200,
        ),
      ),
    );
  }
}
