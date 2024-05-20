import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/ui/widgets/modal_widget.dart';

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
                    "assets/images/pulmoes.png",
                    scale: 14,
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy HH:mm')
                        .format(DateTime.parse(diaphragmaticBreathings.date)),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.03),
                        child: IconButton(
                            icon: const Icon(Icons.edit, size: 25),
                            onPressed: () =>
                                EditModal(store: store).exibirModal(context)),
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
