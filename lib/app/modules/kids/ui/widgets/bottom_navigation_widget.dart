import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home, size: 30),
              onPressed: () {
                Modular.to.navigate("/kids");
              },
              color: Colors.black,
            ),
            IconButton(
              icon: const Icon(Icons.person, size: 30),
              onPressed: () {},
              color: Colors.black,
            ),
            IconButton(
              icon: const Icon(Icons.logout, size: 30),
              onPressed: () {},
              color: Colors.black,
            ),
          ],
        ));
  }
}
