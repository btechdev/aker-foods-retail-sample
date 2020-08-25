import 'package:flutter/material.dart';

class AppBarDetailHeader extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final Key backKey;
  final Key titleKey;

  AppBarDetailHeader({
    Key key,
    this.title,
    this.backKey,
    this.titleKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        key: backKey,
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        title,
        key: titleKey,
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      centerTitle: false,
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(45.0);
}
