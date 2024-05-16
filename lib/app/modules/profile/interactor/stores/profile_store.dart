import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:tooth_ease_frontend/app/modules/profile/data/entities/profile_entities.dart';
import 'package:tooth_ease_frontend/app/modules/shared/interceptor.dart';
import 'package:tooth_ease_frontend/app/modules/shared/secure_storage_service.dart';

import '../../data/services/profile_service.dart';
import '../states/profile_state.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStoreBase with _$ProfileStore;

abstract class _ProfileStoreBase with Store {
  final SecureStorageService storage;
  final ProfileService profileService = Modular.get<ProfileService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserEntity? user;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  @observable
  DateTime selectedDate = DateTime.now();

  _ProfileStoreBase({required this.storage});

  @observable
  ProfileState state = const StartProfileState();

  @action
  emit(ProfileState newState) => state = newState;

  Future getProfile() async {
    emit(const LoadingProfileState());
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    ProfileState response = await profileService.getProfile();
    if (response is SuccessProfileState) {
      user = response.profile.user;
      firstNameController.text = user!.firstName;
      lastNameController.text = user!.lastName;
      if (response.profile.birthDate != null) {
        birthDateController.text =
            inputFormat.format(response.profile.birthDate!);
      } else {
        birthDateController.text = '';
      }

      emit(response);
    } else if (response is ErrorExceptionProfileState) {
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

  Future editProfile() async {
    emit(const LoadingProfileState());
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    final user = PatchUserEntity(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
    );
    final profile = PatchProfileEntity(
      user: user,
      birthDate: inputFormat.parse(birthDateController.text),
    );
    ProfileState response = await profileService.patchProfile(profile, user);
    if (response is SuccessResponseProfileState) {
      getProfile();
      Fluttertoast.showToast(
          msg: "Perfil editado com sucesso",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (response is ErrorExceptionProfileState) {
      Fluttertoast.showToast(
          msg: "Erro ao editar a perfil",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    emit(response);
  }

  @action
  Future<void> selectDate(
      BuildContext context, TextEditingController dataController) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
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
