import 'package:flutter/material.dart';

Widget buttonDesign(String title, IconData icon, Function func) {
  return GestureDetector(
    onTap: () {
      func;
    },
    child: Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          Icon(icon, size: 25, color: Colors.grey[300]),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 20, right: 20),
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
