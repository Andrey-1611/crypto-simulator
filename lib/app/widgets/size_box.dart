import 'package:flutter/material.dart';

class SizeBox extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;

  const SizeBox({super.key, this.height, this.width, this.child});

  const SizeBox.square({super.key, required double size, this.child})
    : height = size,
      width = size;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return SizedBox(
      height: height != null ? screenSize.height * height! : null,
      width: width != null ? screenSize.width * width! : null,
      child: child,
    );
  }
}
