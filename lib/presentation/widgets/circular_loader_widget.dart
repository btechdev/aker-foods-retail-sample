import 'package:flutter/material.dart';

class CircularLoaderWidget extends StatelessWidget {
  const CircularLoaderWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
