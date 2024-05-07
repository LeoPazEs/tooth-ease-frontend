import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tooth_ease_frontend/app/modules/kids/data/entities/error_entities.dart';
import 'package:tooth_ease_frontend/app/modules/shared/interceptor.dart';
import 'package:tooth_ease_frontend/app/modules/shared/secure_storage_service.dart';

import '../../data/entities/kid_entities.dart';
import '../../data/services/kids_service.dart';
import '../states/kids_state.dart';

part 'kids_store.g.dart';

class KidsStore = _KidsStoreBase with _$KidsStore;

abstract class _KidsStoreBase with Store {
  final IKidsService kidsService;
  final SecureStorageService storage;

  @observable
  KidsState state = const StartKidsState();

  List<CompleteKidEntity> kids = [];

  _KidsStoreBase({required this.storage, required this.kidsService});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  final TextEditingController dataController = TextEditingController();

  @action
  emit(KidsState newState) => state = newState;

  @observable
  DateTime selectedDate = DateTime.now();

  @action
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: selectedDate,
    );

    if (pickedDate != null) {
      selectedDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
      );
      dataController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
    }
  }

  Future getKids() async {
    emit(const LoadingKidsState());
    KidsState response = await kidsService.getKids();
    if (response is SuccessKidsState) {
      kids = response.kids;
    } else if (response is ErrorExceptionKidsState) {
      Fluttertoast.showToast(
          msg: "Erro ao buscar os dados",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    emit(response);
  }

  Future createKid(String name, String birthDate) async {
    emit(const LoadingKidsState());
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    final kid = CreateKidEntity(
      name: nameController.text,
      birthDate: inputFormat.parse(dataController.text),
    );
    KidsState response = await kidsService.createKid(kid);
    if (response is SuccessResponseKidsState) {
      getKids();
      Fluttertoast.showToast(
          msg: "Criança cadastrada com sucesso",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (response is ErrorExceptionKidsState) {
      Fluttertoast.showToast(
          msg: "Erro ao cadastrar a criança",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (response is ErrorCreateKidState) {
      ErrorCreateKidEntity error = response.error;
      debugPrint(error.birthDate);
      if (error.detail.isNotEmpty) {
        Fluttertoast.showToast(
            msg: error.detail,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
    emit(response);
  }

  void configure() {
    final dio = Modular.get<Dio>();
    dio.interceptors.add(
      Modular.get<ApiInterceptor>(),
    );
  }

  Future logOut() async {
    await storage.deleteAll();
    Modular.to.navigate("/login");
  }
}
