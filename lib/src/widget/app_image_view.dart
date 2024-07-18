import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum ImageType { asset, network }

class AppImageView extends StatelessWidget {
  const AppImageView({
    super.key,
    required this.imagePath,
    required this.imageType,
    this.width,
    this.height,
  });

  final String imagePath;
  final ImageType imageType;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (imageType == ImageType.asset) {
      return SvgPicture.asset(
        imagePath,
        height: height,
        width: width,
      );
    }
    return SvgPicture.network(
      imagePath,
      height: height,
      width: width,
    );
  }
}
