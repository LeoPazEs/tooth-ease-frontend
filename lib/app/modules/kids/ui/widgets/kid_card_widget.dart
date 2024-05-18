import 'package:flutter/material.dart';
import 'package:tooth_ease_frontend/app/modules/kids/data/entities/kid_entities.dart';
import 'package:tooth_ease_frontend/app/modules/kids/interactor/stores/kids_store.dart';

import 'form_widget.dart';

class KidCardWidget extends StatelessWidget {
  final CompleteKidEntity kid;
  final KidsStore store;

  const KidCardWidget({
    super.key,
    required this.kid,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.005),
      child: Container(
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
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            const Icon(
              Icons.face_6,
              size: 50,
            ),
            Flexible(
                flex: 1,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(kid.name),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    child: IconButton(
                      icon: const Icon(Icons.edit, size: 30),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              surfaceTintColor: Colors.transparent,
                              backgroundColor: Colors.white,
                              title: const Icon(Icons.face_6, size: 50),
                              content:
                                  EditKidFormWidget(store: store, kid: kid),
                            );
                          },
                        );
                      },
                    )),
                Text("Idade: ${kid.age.toString()}"),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
