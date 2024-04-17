import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../data/entities/kid_entities.dart';
import '../../interactor/stores/kids_store.dart';

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
        itemBuilder: (BuildContext context, int index) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.face_6,
                        size: 50,
                      ),
                      Text(kids[index].name),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).size.height *
                                      0.03),
                              child: const Icon(
                                Icons.edit,
                                size: 30,
                              )),
                          Text("Idade: ${kids[index].age.toString()}"),
                        ],
                      ),
                    ]))));
  }
}
