import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../data/entities/kid_entities.dart';
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
  List<KidEntity> kids = [];

  @override
  Widget build(BuildContext context) {
    kids = store.kids;
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: kids.length,
        itemBuilder: (BuildContext context, int index) => KidCardWidget(
              kid: kids[index],
            ));
  }
}
