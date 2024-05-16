import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import '../../interactor/stores/profile_store.dart';
import '../widgets/form_widget.dart';
import '../widgets/form_box_widget.dart';

class ProfileWidget extends StatefulWidget {
  final ProfileStore store;
  const ProfileWidget({super.key, required this.store});
  @override
  ProfileWidgetState createState() => ProfileWidgetState();
}

class ProfileWidgetState extends State<ProfileWidget> {
  final ProfileStore store = Modular.get<ProfileStore>();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FormBoxWidget(
          user: store.user,
          children: [
            ProfileFormWidget(
              store: store,
            ),
          ],
        )
      ],
    ));
  }
}
