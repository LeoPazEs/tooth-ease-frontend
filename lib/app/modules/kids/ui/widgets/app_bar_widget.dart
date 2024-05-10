import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tooth_ease_frontend/app/modules/kids/interactor/stores/kids_store.dart';
import 'package:tooth_ease_frontend/app/modules/kids/ui/widgets/form_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  AppBarWidget({
    super.key,
    required this.title,
  });

  final KidsStore store = Modular.get<KidsStore>();

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
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    surfaceTintColor: Colors.transparent,
                    backgroundColor: Colors.white,
                    title: const Icon(Icons.face_6, size: 50),
                    content: AddKidFormWidget(store: store),
                  );
                },
              );
            },
          ),
        ]);
  }
}
