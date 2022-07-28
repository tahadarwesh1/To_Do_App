import 'package:flutter/material.dart';
import 'package:to_do_app/shared/styles.dart';

class DefaultTextForm extends StatelessWidget {
  final String text;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final String? hintText;
  final String? validator;
  final void Function()? onTap;
  const DefaultTextForm({
    Key? key,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.suffixIcon,
    this.hintText,
    required this.validator,
    this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 60,
          child: TextFormField(
            keyboardType: keyboardType,
            validator: (value) {
              if (value!.isEmpty) {
                return validator;
              }
              return null;
            },
            controller: controller,
            style: kTextFieldStyle,
            maxLines: 1,
            onTap: onTap,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              fillColor: Colors.grey[180],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              suffixIcon: suffixIcon,
              suffixIconColor: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
