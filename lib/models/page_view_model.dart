import 'package:flutter/material.dart';

class PageViewModel {
  final Widget background;
  final Widget body;
  final Widget bubble;
  final Color bubbleBackgroundColor;

  PageViewModel({
    this.background,
    this.bubbleBackgroundColor = const Color(0x88FFFFFF),
    @required this.body,
    this.bubble,
  });
}
