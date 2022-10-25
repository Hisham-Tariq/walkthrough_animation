import 'package:flutter/material.dart';
import 'package:walkthrough_animation/extensions/duration.dart';

import '../constants.dart';

class AnimatedWalkthroughImage extends StatelessWidget {
  const AnimatedWalkthroughImage({
    super.key,
    required this.currentIndex,
    required this.index,
    required this.imagePath,
    this.baseDuration = defaultAnimationDuration,
    required this.offset,
  });
  final int currentIndex, index;
  final String imagePath;
  final Duration baseDuration;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      curve: Curves.fastOutSlowIn,
      duration: baseDuration.delay(
        milliseconds: currentIndex == index ? 200 : 0,
      ),
      offset: offset,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Image.asset(imagePath),
      ),
    );
  }
}
