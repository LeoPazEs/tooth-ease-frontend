import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tooth_ease_frontend/app/modules/profile/interactor/stores/profile_store.dart';
import 'package:flutter/material.dart';
import 'package:tooth_ease_frontend/app/modules/profile/ui/widgets/bottom_navigation_widget.dart';

import '../../interactor/states/profile_state.dart';
import '../widgets/background_widget.dart';
import '../widgets/loading_wiget.dart';
import '../widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  const ProfilePage({super.key, this.title = 'ProfilePage'});
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final ProfileStore store = Modular.get<ProfileStore>();

  @override
  void initState() {
    store.configure();
    store.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BottomNavigationWidget(store: store, storage: store.storage),
      resizeToAvoidBottomInset: false,
      body: Observer(
        builder: (context) {
          return (store.state is LoadingProfileState)
              ? Stack(
                  children: [
                    const BackgroundWidget(),
                    ProfileWidget(store: store),
                    const Loading()
                  ],
                )
              : Stack(
                  children: [
                    const BackgroundWidget(),
                    ProfileWidget(store: store)
                  ],
                );
        },
      ),
    );
  }
}
