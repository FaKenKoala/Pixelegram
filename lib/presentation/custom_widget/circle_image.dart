import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final ImageProvider image;
  final String? text;

  const CircleImage({Key? key, required this.image, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        shape: BoxShape.circle,
        image: text == null
            ? DecorationImage(image: image, fit: BoxFit.contain)
            : null,
      ),
      child: text != null
          ? Center(
            child: Text(
                text ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24
                ),
              ),
          )
          : null,
    );
  }
}
