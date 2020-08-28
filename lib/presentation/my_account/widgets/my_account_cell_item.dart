import 'package:flutter/material.dart';

class MyAccountCellItem {
  final IconData icon;
  final String title;
  final String subtitle;
  // final int index;

  MyAccountCellItem({
    @required this.icon,
    @required this.title,
    // @required this.index,
    this.subtitle,
  });
}
