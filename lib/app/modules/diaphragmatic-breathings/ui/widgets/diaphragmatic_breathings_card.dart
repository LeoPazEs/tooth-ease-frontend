import 'package:flutter/material.dart';

import '../../data/entities/diaphragmatic_breathings_entity.dart';
import '../../interactor/stores/diaphragmaticBreathings_store.dart';

class DiaphragmaticBreathingsCardWidget extends StatelessWidget {
  final DiaphragmaticBreathingsEntity diaphragmaticBreathings;
  final DiaphragmaticBreathingsStore store;

  const DiaphragmaticBreathingsCardWidget({
    super.key,
    required this.diaphragmaticBreathings,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/tooth.png",
                    scale: 15,
                  ),
                  Text(
                    diaphragmaticBreathings.date,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.03),
                        child: GestureDetector(
                          child: const Icon(
                            Icons.edit,
                            size: 25,
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
