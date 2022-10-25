import 'package:flutter/material.dart';
import 'package:walkthrough_animation/extensions/duration.dart';

import '../constants.dart';

class AnimatedWalkthroughTitle extends StatelessWidget {
  const AnimatedWalkthroughTitle({
    super.key,
    required this.currentIndex,
    required this.index,
    required this.title,
    this.baseDuration = defaultAnimationDuration,
    required this.offset,
  });
  final int currentIndex, index;
  final String title;
  final Duration baseDuration;
  final Offset offset;
  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: offset,
      duration: baseDuration.delay(milliseconds: currentIndex == index ? 400 : 0),
      curve: Curves.fastOutSlowIn,
      child: Center(
        child: Text(
          title,
          style: AppTextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
