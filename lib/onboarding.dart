library flutter_intro_views;

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_intro_views/animation_gesture/animated_page_dragger.dart';
import 'package:flutter_intro_views/animation_gesture/page_dragger.dart';
import 'package:flutter_intro_views/animation_gesture/page_reveal.dart';
import 'package:flutter_intro_views/constants/constants.dart';
import 'package:flutter_intro_views/models/page_view_model.dart';
import 'package:flutter_intro_views/models/pager_indicator_view_model.dart';
import 'package:flutter_intro_views/models/slide_update_model.dart';
import 'package:flutter_intro_views/ui/page_indicator_buttons.dart';
import 'package:flutter_intro_views/ui/pager_indicator.dart';

/// This is the IntroViewsFlutter widget of app which is a stateful widget as its state is dynamic and updates asynchronously.
class Onboarding extends StatefulWidget {
  /// List of [PageViewModel] to display
  final List<PageViewModel> pages;

  /// Callback on Done Button Pressed
  final VoidCallback onTapDoneButton;

  /// set the Text Color for skip, done buttons
  /// gets overiden by [pageButtonTextStyles]
  final Color pageButtonsColor;

  /// Whether you want to show the skip button or not.
  final bool showSkipButton;

  /// Whether you want to show the next button or not.
  final bool showNextButton;

  /// Whether you want to show the back button or not.
  final bool showBackButton;

  /// TextStyles for done, skip Buttons
  /// overrides [pageButtonFontFamily] [pageButtonsColor] [pageButtonTextSize]
  final TextStyle pageButtonTextStyles;

  /// run a function after skip Button pressed
  final VoidCallback onTapSkipButton;

  /// run a function after next Button pressed
  final VoidCallback onTapNextButton;

  /// run a function after back Button pressed
  final VoidCallback onTapBackButton;

  /// set the Text Size for skip, done buttons
  /// gets overridden by [pageButtonTextStyles]
  final double pageButtonTextSize;

  /// set the Font Family for skip, done buttons
  /// gets overridden by [pageButtonTextStyles]
  final String pageButtonFontFamily;

  /// Override 'DONE' Text with Your Own Text,
  /// typicaly a Text Widget
  final Widget doneText;

  /// Override 'BACK' Text with Your Own Text,
  /// typicaly a Text Widget
  final Widget backText;

  /// Override 'NEXT' Text with Your Own Text,
  /// typicaly a Text Widget
  final Widget nextText;

  /// Override 'Skip' Text with Your Own Text,
  /// typicaly a Text Widget
  final Widget skipText;

  /// always Show DoneButton
  final bool doneButtonPersist;

  /// [MainAxisAlignment] for [PageViewModel] page column aligment
  /// default [MainAxisAligment.spaceAround]
  ///
  /// portrait view wraps around  [title] [body] [mainImage]
  ///
  /// landscape view wraps around [title] [body]
  final MainAxisAlignment columnMainAxisAlignment;

  /// ajust how how much the user most drag for a full page transition
  ///
  /// default to 300.0
  final double fullTransition;

  final Color background;

  Onboarding(
    this.pages, {
    Key key,
    this.onTapDoneButton,
    this.showSkipButton = true,
    this.pageButtonTextStyles,
    this.onTapBackButton,
    this.showNextButton = false,
    this.showBackButton = false,
    this.pageButtonTextSize = 18.0,
    this.pageButtonFontFamily,
    this.onTapSkipButton,
    this.onTapNextButton,
    this.pageButtonsColor,
    this.doneText = const Text("DONE"),
    this.nextText = const Text("NEXT"),
    this.skipText = const Text("SKIP"),
    this.backText = const Text("BACK"),
    this.doneButtonPersist = false,
    this.columnMainAxisAlignment = MainAxisAlignment.spaceAround,
    this.fullTransition = FULL_TRANSITION_PX,
    this.background,
  }) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDragger animatedPageDragger;
  int activePageIndex = 0;
  int nextPageIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;
  StreamSubscription<SlideUpdate> slideUpdateStream$;

  @override
  void initState() {
    slideUpdateStream = StreamController<SlideUpdate>();
    slideUpdateStream$ = slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = max(0, activePageIndex - 1);
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = min(widget.pages.length - 1, activePageIndex + 1);
          } else {
            nextPageIndex = activePageIndex;
          }
        } else if (event.updateType == UpdateType.doneDragging) {
          if (slidePercent > 0.5) {
            animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          } else {
            animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
            nextPageIndex = activePageIndex;
          }
          animatedPageDragger.run();
        } else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneAnimating) {
          activePageIndex = nextPageIndex;
          slideDirection = SlideDirection.none;
          slidePercent = 0.0;
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    slideUpdateStream$?.cancel();
    animatedPageDragger?.dispose();
    slideUpdateStream?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
        TextStyle(fontSize: widget.pageButtonTextSize ?? 18.0, color: widget.pageButtonsColor ?? const Color(0x88FFFFFF), fontFamily: widget.pageButtonFontFamily).merge(widget.pageButtonTextStyles);

    List<PageViewModel> pages = widget.pages;

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: widget.background,
      body: Stack(
        children: <Widget>[
          Stack(
            fit: StackFit.expand,
            children: <Widget>[
              pages[activePageIndex].background,
              SafeArea(
                child: pages[activePageIndex].body,
              ),
            ],
          ),
          PageReveal(
            //next page reveal
            revealPercent: slidePercent,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                pages[nextPageIndex].background,
                SafeArea(
                  child: pages[nextPageIndex].body,
                ),
              ],
            ),
          ),
          PagerIndicator(
            //bottom page indicator
            viewModel: PagerIndicatorViewModel(
              pages,
              activePageIndex,
              slideDirection,
              slidePercent,
            ),
          ),
          PageIndicatorButtons(
            textStyle: textStyle,
            activePageIndex: activePageIndex,
            totalPages: pages.length,
            onPressedDoneButton: widget.onTapDoneButton,
            slidePercent: slidePercent,
            slideDirection: slideDirection,
            onPressedSkipButton: () {
              setState(() {
                activePageIndex = pages.length - 1;
                nextPageIndex = activePageIndex;
                if (widget.onTapSkipButton != null) {
                  widget.onTapSkipButton();
                }
              });
            },
            showSkipButton: widget.showSkipButton,
            showNextButton: widget.showNextButton,
            showBackButton: widget.showBackButton,
            onPressedNextButton: () {
              setState(() {
                activePageIndex = min(pages.length - 1, activePageIndex + 1);
                nextPageIndex = min(pages.length - 1, nextPageIndex + 1);
                if (widget.onTapNextButton != null) {
                  widget.onTapNextButton();
                }
              });
            },
            onPressedBackButton: () {
              setState(() {
                activePageIndex = max(0, activePageIndex - 1);
                nextPageIndex = max(0, nextPageIndex - 1);
                if (widget.onTapBackButton != null) {
                  widget.onTapBackButton();
                }
              });
            },
            nextText: widget.nextText,
            doneText: widget.doneText,
            backText: widget.backText,
            skipText: widget.skipText,
            doneButtonPersist: widget.doneButtonPersist,
          ),
          PageDragger(
            fullTransitionPX: widget.fullTransition,
            canDragLeftToRight: activePageIndex > 0,
            canDragRightToLeft: activePageIndex < pages.length - 1,
            slideUpdateStream: this.slideUpdateStream,
          ),
        ],
      ), //Stack
    );
  }
}
