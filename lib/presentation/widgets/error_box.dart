import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  final String errorMessage;

  const ErrorBox({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 1,
            color: Colors.orange.shade800,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.amber.shade900,
            ),
          ),
        ),
      ),
    );
  }
}
