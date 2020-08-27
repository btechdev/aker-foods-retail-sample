import 'package:flutter/material.dart';

import '../extensions/pixel_dimension_util_extensions.dart';

// ignore: must_be_immutable
class CountdownTimerText extends AnimatedWidget {
  Animation<int> animation;

  CountdownTimerText({
    Key key,
    this.animation,
  }) : super(
          key: key,
          listenable: animation,
        );

  @override
  Widget build(BuildContext context) {
    final Duration clockTimerDuration = Duration(seconds: animation.value);

    final minutes = clockTimerDuration.inMinutes.remainder(60);
    final String minutesText = '${minutes.toString().padLeft(2, '0')}';

    final seconds = clockTimerDuration.inSeconds.remainder(60) % 60;
    final String secondsText = '${seconds.toString().padLeft(2, '0')}';

    return Row(
      children: [
        _text(context, 'Wait'),
        SizedBox(width: 4.w),
        timeTextContainer(context, minutesText),
        _text(context, ':'),
        timeTextContainer(context, secondsText),
      ],
    );
  }

  Container timeTextContainer(BuildContext context, String text) => Container(
        width: 18.w,
        alignment: Alignment.center,
        child: _text(context, text),
      );

  Text _text(BuildContext context, String text) => Text(
        text,
        overflow: TextOverflow.fade,
        maxLines: 1,
        style: Theme.of(context).textTheme.overline,
      );
}
