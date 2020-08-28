import 'package:flutter/material.dart';

class MyAccountOptionDataEntity {
  final IconData icon;
  final String title;
  final String subtitle;

  MyAccountOptionDataEntity({
    @required this.icon,
    @required this.title,
    this.subtitle,
  });
}
