// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class ImageNotFound extends StatelessWidget {
  const ImageNotFound({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.image_not_supported,
          size: 50,
          color: Colors.black45,
        ),
        const SizedBox(height: 8),
        Text(
          'Image not found',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}