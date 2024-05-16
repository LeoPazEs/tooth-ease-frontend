import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tooth_ease_frontend/app/modules/profile/interactor/stores/profile_store.dart';
import 'package:tooth_ease_frontend/app/modules/shared/secure_storage_service.dart';

class BottomNavigationWidget extends StatelessWidget {
  final ProfileStore store;
  final SecureStorageService storage;

  const BottomNavigationWidget({
    super.key,
    required this.storage,
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
              onPressed: () {
                Modular.to.navigate("/home");
              },
              color: Colors.black,
            ),
            IconButton(
              icon: const Icon(Icons.person, size: 30),
              onPressed: () {
                Modular.to.navigate("/profile");
              },
              color: Colors.black,
            ),
            IconButton(
              icon: const Icon(Icons.logout, size: 30),
              onPressed: () => store.logOut(),
              color: Colors.black,
            ),
          ],
        ));
  }
}
