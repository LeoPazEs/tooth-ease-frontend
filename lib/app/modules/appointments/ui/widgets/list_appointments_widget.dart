import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/interactor/stores/appointments_store.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/ui/widgets/appointments_card_widget.dart';

class AppointmentWidget extends StatefulWidget {
  final AppointmentsStore store;
  const AppointmentWidget({super.key, required this.store});
  @override
  AppointmentWidgetState createState() => AppointmentWidgetState();
}

class AppointmentWidgetState extends State<AppointmentWidget> {
  final AppointmentsStore store = Modular.get<AppointmentsStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: store.appointments.length,
          itemBuilder: (BuildContext context, int index) =>
              AppointmentsCardWidget(
            appointments: store.appointments[index],
            store: store,
          ),
        );
      },
    );
  }
}
