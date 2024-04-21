import 'package:flutter/material.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/interactor/stores/appointments_store.dart';

class BottomNavigationWidget extends StatelessWidget {
  final AppointmentsStore store;
  const BottomNavigationWidget({
    super.key,
    required this.store,
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
              onPressed: () {},
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
