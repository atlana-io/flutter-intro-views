import 'package:flutter/material.dart';
import 'package:flutter_intro_views/constants/constants.dart';
import 'package:flutter_intro_views/models/page_bubble_view_model.dart';
import 'package:flutter_intro_views/models/pager_indicator_view_model.dart';
import 'package:flutter_intro_views/ui/page_bubble.dart';

class PagerIndicator extends StatelessWidget {
  final PagerIndicatorViewModel viewModel;

  PagerIndicator({this.viewModel});

  @override
  Widget build(BuildContext context) {
    //Extracting page bubble information from page view model
    List<PageBubble> bubbles = [];

    for (var i = 0; i < viewModel.pages.length; i++) {
      final page = viewModel.pages[i];

      //calculating percent active
      var percentActive;
      if (i == viewModel.activeIndex) {
        percentActive = 1.0 - viewModel.slidePercent;
      } else if (i == viewModel.activeIndex - 1 && viewModel.slideDirection == SlideDirection.leftToRight) {
        percentActive = viewModel.slidePercent;
      } else if (i == viewModel.activeIndex + 1 && viewModel.slideDirection == SlideDirection.rightToLeft) {
        percentActive = viewModel.slidePercent;
      } else {
        percentActive = 0.0;
      }

      //Checking is that bubble hollow
      bool isHollow = i > viewModel.activeIndex || (i == viewModel.activeIndex && viewModel.slideDirection == SlideDirection.leftToRight);

      //Adding to the list
      bubbles.add(
        PageBubble(
          viewModel: PageBubbleViewModel(
            isHollow: isHollow,
            activePercent: percentActive,
            bubbleBackgroundColor: page.bubbleBackgroundColor,
            bubbleInner: page.bubble,
          ),
        ),
      );
    }

    //Calculating the translation value of pager indicator while sliding.
    final baseTranslation = ((viewModel.pages.length * BUBBLE_WIDTH) / 2) - (BUBBLE_WIDTH / 2);
    var translation = baseTranslation - (viewModel.activeIndex * BUBBLE_WIDTH);

    if (viewModel.slideDirection == SlideDirection.leftToRight) {
      translation += BUBBLE_WIDTH * viewModel.slidePercent;
    } else if (viewModel.slideDirection == SlideDirection.rightToLeft) {
      translation -= BUBBLE_WIDTH * viewModel.slidePercent;
    }

    return Column(
      children: <Widget>[
        Expanded(child: Container()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform(
              // used for horizontal transformation
              transform: Matrix4.translationValues(translation, 0.0, 0.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: bubbles,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
