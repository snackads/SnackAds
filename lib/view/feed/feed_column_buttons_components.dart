import 'package:flutter/material.dart';

Widget columnButtonsComponent(String title, Icon icon, Function func) {
  return GestureDetector(
    onTap: () {
      //
    },
    child: Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          icon,
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
