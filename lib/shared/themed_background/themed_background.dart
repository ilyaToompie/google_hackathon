import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isDarkModeProvider = StateProvider<bool>((ref) => false);

class ThemedBackground extends ConsumerWidget {
  final Widget child;
  final double? blur;
  final double? dialate;
  final bool gradientBlur;

  const ThemedBackground({
    super.key,
    required this.child,
    this.blur = 1.0,
    this.dialate = 1.0,
    this.gradientBlur = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final image =
        isDark
            ? 'assets/images/background_grid_dark.png'
            : 'assets/images/background_grid_light.png';

    final backgroundImage = Image.asset(image, fit: BoxFit.cover);

    return Stack(
      fit: StackFit.expand,
      children: [
        if (gradientBlur)
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                begin: Alignment(0, -1),
                end: Alignment(0, 2),
                colors: [Colors.transparent, Colors.black],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: ImageFiltered(
              imageFilter: ImageFilter.dilate(
                radiusX: dialate!,
                radiusY: dialate!,
              ),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: blur!, sigmaY: blur!),
                child: backgroundImage,
              ),
            ),
          )
        else if ((blur ?? 0.0) > 0.0 && (dialate ?? 0.0) > 0.0)
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: blur!, sigmaY: blur!),
            child: ImageFiltered(
              imageFilter: ImageFilter.dilate(
                radiusX: dialate! + .15,
                radiusY: dialate!,
              ),
              child: backgroundImage,
            ),
          )
        else
          backgroundImage,
        child,
      ],
    );
  }
}
