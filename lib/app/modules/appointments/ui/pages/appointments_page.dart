import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/interactor/state/appointments_state.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/interactor/stores/appointments_store.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/ui/widgets/background_widget.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/ui/widgets/bottom_navigation_widget.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/ui/widgets/empty_widget.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/ui/widgets/error_widget.dart';
import 'package:tooth_ease_frontend/app/modules/diaphragmatic-breathings/ui/widgets/loading_wiget.dart';
import 'package:tooth_ease_frontend/app/modules/appointments/ui/widgets/modal_filter_widget.dart';

import '../widgets/list_appointments_widget.dart';
import '../widgets/modal_widget.dart';

class AppointmentsPage extends StatefulWidget {
  final String title;
  const AppointmentsPage({Key? key, this.title = 'Consultas'})
      : super(key: key);
  @override
  AppointmentsPageState createState() => AppointmentsPageState();
}

class AppointmentsPageState extends State<AppointmentsPage> {
  final AppointmentsStore store = Modular.get();

  @override
  void initState() {
    store.getAppointmentsAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationWidget(store: store),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add_rounded, size: 35),
              onPressed: () {
                store.clearController();
                ConsultaModal(store: store).exibirModal(context);
              }),
          IconButton(
              icon: const Icon(Icons.manage_search_outlined, size: 35),
              onPressed: () {
                store.clearController();
                FilterModal(store: store).exibirModal(context);
              }),
        ],
      ),
      body: Observer(
        builder: (context) {
          if (store.state is LoadingAppointmentsState) {
            return Stack(children: [
              const BackgroundWidget(),
              AppointmentWidget(store: store),
              const Loading()
            ]);
          } else if (store.state is SuccessAppointmentsState) {
            return Stack(children: [
              const BackgroundWidget(),
              AppointmentWidget(store: store)
            ]);
          } else if (store.state is EmptyAppointmentsState) {
            return const Stack(children: [
              BackgroundWidget(),
              EmptyWidget(),
            ]);
          } else {
            return const ErrorAppointmentsWidget();
          }
        },
      ),
    );
  }
}
