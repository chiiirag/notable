import 'package:flutter/material.dart';
import 'package:notable/src/widget/app_text.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.validator,
    required this.controller,
    this.labelText,
    this.borderWidth = 1.0,
  });

  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  final String? labelText;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        label: labelText != null ? AppText(labelText!) : null,
        border: InputBorder.none,
        fillColor: Colors.white,
        focusColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        errorBorder: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(),
        focusedErrorBorder: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
      ),
    );
  }
}
