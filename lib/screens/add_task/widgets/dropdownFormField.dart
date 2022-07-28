import 'package:flutter/material.dart';
import 'package:to_do_app/shared/styles.dart';

class DefaultDropdownFormField extends StatelessWidget {
  final String text;
  final Widget? suffixIcon;
  final String? hintText;
  final String? validator;
  final List<DropdownMenuItem<dynamic>>? items;
  final void Function()? onTap;
  final void Function(dynamic)? onChanged;
  const DefaultDropdownFormField({
    Key? key,
    this.suffixIcon,
    this.hintText,
    required this.validator,
    required this.items,
    required this.onChanged,
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
          height: 56,
          child: DropdownButtonFormField<dynamic>(
            items: items,
            onChanged: onChanged,
            style: kTextFieldStyle,
            onTap: onTap,
            icon: const Icon(Icons.keyboard_arrow_down),
            iconEnabledColor: Colors.grey,
            iconSize: 24,
            validator: ((value) {
              if (value == null) {
                return validator;
              } else {
                return null;
              }
            }),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              fillColor: Colors.grey[180],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
            ),
          ),
        ),
      ],
    );
  }
}
