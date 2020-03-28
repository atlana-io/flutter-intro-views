import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_intro_views/models/page_bubble_view_model.dart';

class PageBubble extends StatelessWidget {
  final PageBubbleViewModel viewModel;

  PageBubble({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55.0,
      height: 65.0,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: lerpDouble(20.0, 45.0, viewModel.activePercent), //This method return in between values according to active percent.
            height: lerpDouble(20.0, 45.0, viewModel.activePercent),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              //Alpha is used to create fade effect for background color
              color: viewModel.isHollow ? viewModel.bubbleBackgroundColor.withAlpha((0x88 * viewModel.activePercent).round()) : viewModel.bubbleBackgroundColor,
              border: Border.all(
                color: viewModel.isHollow ? viewModel.bubbleBackgroundColor.withAlpha((0x88 * (1 - viewModel.activePercent)).round()) : Colors.transparent,
                width: 3.0,
              ), //Border
            ), //BoxDecoration
            child: Opacity(
              opacity: viewModel.activePercent,
              child: viewModel.bubbleInner != null
                  ? Transform.scale(
                      scale: viewModel.activePercent.clamp(0.5, 1.0),
                      child: viewModel.bubbleInner,
                    )
                  : Container(),
            ), //opacity
          ), //Container
        ), //Padding
      ), //Center
    ); //Container
  }
}
