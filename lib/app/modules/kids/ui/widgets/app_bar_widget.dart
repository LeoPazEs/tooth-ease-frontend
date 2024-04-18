import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarWidget({
    super.key,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Text(title),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
        elevation: 5.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_rounded, size: 50),
            onPressed: () {},
          )
        ]);
  }
}
