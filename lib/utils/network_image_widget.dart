import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'color.dart';

class NetworkImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final BorderRadius? borderRadius;

  const NetworkImageWidget({
    Key? key,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.imageUrl,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius!,
      child: Image.network(
        imageUrl ??
            "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=928&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        fit: fit ?? BoxFit.cover,
        height: height,
        width: width,
        color: color,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: Lottie.asset(
                'assets/json/loader.json',
                height: 100,
                width: 100,
              ),
            );
          }
        },
        errorBuilder: (context, error, stackTrace) {
          log("Image Widget load error $error");
          return const Icon(Icons.error, color: primaryBlack);
        },
      ),
    );
  }
}
