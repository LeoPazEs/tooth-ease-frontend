import 'package:flutter_modular/flutter_modular.dart';
import 'package:tooth_ease_frontend/app/modules/profile/interactor/stores/profile_store.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  const ProfilePage({Key? key, this.title = 'ProfilePage'}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final ProfileStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationWidget(store: store),
      appBar: AppBarWidget(title: widget.title),
      resizeToAvoidBottomInset: false,
    );
  }
}
