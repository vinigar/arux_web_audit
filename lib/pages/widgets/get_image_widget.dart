import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

Widget? getImage(String? image, {double height = 180}) {
  if (image == null) {
    return null;
  } else if (image.startsWith('http') || image.startsWith('https')) {
    return FadeInImage(
      height: 180,
      width: double.infinity,
      placeholder: const AssetImage('assets/images/animation_500_l3ur8tqa.gif'),
      image: NetworkImage(image),
      fit: BoxFit.cover,
    );
  }
  return Image.file(
    File(image),
    height: height,
    width: double.infinity,
    fit: BoxFit.cover,
  );
}

Widget? getUserImage(Uint8List? image, {double height = 180}) {
  if (image == null) {
    return Image.asset('assets/images/default-user-profile-picture.png');
  } else {
    return Image.memory(
      image,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
