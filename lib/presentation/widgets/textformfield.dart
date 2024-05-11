import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
  final String? hint;
  final String? label;
  final TextInputType? inputType;
  final TextEditingController controller;
  final Function(String)? validator;
  final Function()? onTap;
  final Widget? suffixIcon;
  final bool? enabled;

  const TextFormFieldCustom({
    super.key,
    required this.controller,
    this.inputType = TextInputType.text,
    this.hint = '',
    this.validator,
    this.label = '',
    this.onTap,
    this.suffixIcon,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade50,
            borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: TextFormField(
            controller: controller,
            keyboardType: inputType,
            enabled: enabled,
            onTap: onTap,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.blueGrey.shade400),
              label: label!.isNotEmpty ? Text(label!) : null,
              // errorBorder: const UnderlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              errorStyle: TextStyle(
                color: Colors.red.shade700,
                fontSize: 9,
              ),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              suffixIcon: suffixIcon,
            ),
            validator: (value) {
              if (validator != null) {
                return validator!(value!);
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
