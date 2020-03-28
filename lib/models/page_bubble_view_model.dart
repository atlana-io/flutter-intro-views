import 'package:flutter/material.dart';

// View Model for page bubble

class PageBubbleViewModel {
  final bool isHollow;
  final double activePercent;
  final Color bubbleBackgroundColor;
  final Widget bubbleInner;

  PageBubbleViewModel({
    this.bubbleInner,
    this.isHollow,
    this.activePercent,
    this.bubbleBackgroundColor = const Color(0x88FFFFFF),
  }) : assert(bubbleBackgroundColor != null);
}
