import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final ImageProvider image;
  const CircleImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        shape: BoxShape.circle,
        image: DecorationImage(image: image, fit: BoxFit.contain),
      ),
    );
  }
}
