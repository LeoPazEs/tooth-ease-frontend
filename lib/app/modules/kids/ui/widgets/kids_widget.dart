import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../interactor/stores/kids_store.dart';
import 'kid_card_widget.dart';

class KidsWidget extends StatefulWidget {
  final KidsStore store;
  const KidsWidget({super.key, required this.store});
  @override
  KidsWidgetState createState() => KidsWidgetState();
}

class KidsWidgetState extends State<KidsWidget> {
  final KidsStore store = Modular.get<KidsStore>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: store.kids.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () => Modular.to
            .pushNamed("/appointments/", arguments: store.kids[index].id),
        child: KidCardWidget(
          kid: store.kids[index],
        ),
      ),
    );
  }
}
