import 'package:flutter/material.dart';

class AppbarWidget extends AppBar {
  AppbarWidget.normal(
    BuildContext context, {
    @required String title,
    bool centerTitle = false,
    Function onTapBack,
    Color backgroundColor = Colors.blue,
    List<Widget> actions,
  }) : super(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: onTapBack ??
                () {
                  Navigator.of(context).pop();
                },
          ),
          centerTitle: centerTitle,
          title: Text(
            title ?? ' ',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: backgroundColor,
          actions: actions,
        );
}
