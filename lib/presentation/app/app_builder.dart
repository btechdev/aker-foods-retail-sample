import 'package:flutter/material.dart';

class AppBuilder extends StatefulWidget {
  final Function(BuildContext) builder;

  const AppBuilder({
    Key key,
    this.builder,
  }) : super(key: key);

  @override
  AppBuilderState createState() => AppBuilderState();

  static AppBuilderState of(BuildContext context) {
    //return context.ancestorStateOfType(const TypeMatcher<AppBuilderState>());
    return context.findAncestorStateOfType<AppBuilderState>();
  }
}

class AppBuilderState extends State<AppBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }

  void rebuild() {
    setState(() {});
  }
}