import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
    this.imagePath = 'assets/images/spy_bg.png',
    this.repeat = false,
    this.overlayAlpha = 0.35, // fading overlay
  });

  final Widget child;
  final String imagePath;
  final bool repeat;
  final double overlayAlpha;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: repeat
              ? DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      repeat: ImageRepeat.repeat,
                      alignment: Alignment.topLeft,
                    ),
                  ),
                )
              : Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
        ),
        Positioned.fill(
          child: Container(color: Colors.black.withValues(alpha: overlayAlpha)),
        ),
        SafeArea(child: child),
      ],
    );
  }
}
