import 'dart:convert';

import 'package:flutter/material.dart';

class Base64Image extends StatelessWidget {
  final String base64Str;
  final WidgetBuilder? childBuilder;

  const Base64Image({Key? key, required this.base64Str, this.childBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        image: DecorationImage(
            image: MemoryImage(base64Decode(base64Str)), fit: BoxFit.cover),
      ),
      child: childBuilder?.call(context),
    );
  }
}
