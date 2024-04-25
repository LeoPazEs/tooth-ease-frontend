import 'package:flutter/material.dart';
import 'package:tooth_ease_frontend/app/modules/kids/data/entities/kid_entities.dart';

class KidCardWidget extends StatelessWidget {
  final KidEntity kid;

  const KidCardWidget({
    super.key,
    required this.kid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.face_6,
                    size: 50,
                  ),
                  Text(kid.name),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.03),
                          child: const Icon(
                            Icons.edit,
                            size: 30,
                          )),
                      Text("Idade: ${kid.age.toString()}"),
                    ],
                  ),
                ])));
  }
}
