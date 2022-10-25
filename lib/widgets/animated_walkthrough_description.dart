import 'package:flutter/material.dart';
import 'package:walkthrough_animation/extensions/duration.dart';

import '../constants.dart';

class AnimatedWalkthroughDescription extends StatelessWidget {
  const AnimatedWalkthroughDescription({
    super.key,
    required this.currentIndex,
    required this.index,
    required this.description,
    this.baseDuration = defaultAnimationDuration, 
    required this.offset,
  });
  final int currentIndex, index;
  final String description;
  final Duration baseDuration;
  final Offset offset;
  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: offset,
      duration: baseDuration.delay(milliseconds: 100).delay(
            milliseconds: currentIndex == index ? 200 : 0,
          ),
      curve: Curves.fastOutSlowIn,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Text(
          description,
          textAlign: TextAlign.center,
          style: AppTextStyle(
            letterSpacing: 1.2,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
