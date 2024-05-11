import 'package:flutter/material.dart';

class PassField extends StatelessWidget {
  final String? hint;
  final String? label;
  final TextInputType? inputType;
  final TextEditingController controller;
  final Function(String)? validator;
  final Function()? onTap;
  final Widget? suffixIcon;
  final bool? obscureText;

  const PassField({
    super.key,
    required this.controller,
    this.inputType = TextInputType.text,
    this.hint = 'Password',
    this.validator,
    this.label = '',
    this.onTap,
    this.suffixIcon,
    this.obscureText = false,
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
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: inputType,
                  onTap: onTap,
                  obscureText: obscureText!,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.blueGrey.shade400),
                    labelText: label,
                    // errorBorder: const UnderlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    errorStyle:
                        TextStyle(color: Colors.red.shade700, fontSize: 9),

                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  validator: (value) {
                    if (validator != null) {
                      return validator!(value!);
                    }
                    return null;
                  },
                ),
              ),
              if (suffixIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: suffixIcon,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
