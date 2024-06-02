import 'package:flutter/material.dart';

void infoSnackBar({required BuildContext context, required String msg}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
    ),
  );
}