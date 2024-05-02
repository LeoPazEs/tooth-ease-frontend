import 'package:flutter/material.dart';
import 'package:tooth_ease_frontend/app/modules/kids/data/entities/error_entities.dart';

import '../../interactor/states/kids_state.dart';
import '../../interactor/stores/kids_store.dart';

class AddKidFormWidget extends StatefulWidget {
  const AddKidFormWidget({super.key, required this.store});
  final KidsStore store;

  @override
  State<AddKidFormWidget> createState() => _AddKidFormWidgetState();
}

class _AddKidFormWidgetState extends State<AddKidFormWidget> {
  String nameError = "";
  String birthDateError = "";

  @override
  Widget build(BuildContext context) {
    final EdgeInsets paddingFormFields =
        EdgeInsets.all(MediaQuery.of(context).size.height * 0.005);

    final EdgeInsets contentPaddingFormFields = EdgeInsets.only(
      left: MediaQuery.of(context).size.height * 0.01,
    );

    const borderFormFields =
        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)));

    return Form(
        key: widget.store.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: paddingFormFields,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    contentPadding: contentPaddingFormFields,
                    border: borderFormFields,
                    errorText: nameError.isNotEmpty ? birthDateError : null,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (nome) {
                    if (nome == null || nome.isEmpty) {
                      return 'Por favor, insira um nome';
                    }
                    return null;
                  },
                  controller: widget.store.nameController,
                  onChanged: (value) {
                    setState(() {
                      nameError = '';
                    });
                  },
                )),
            Padding(
                padding: paddingFormFields,
                child: TextFormField(
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      labelText: 'Data de nascimento',
                      contentPadding: contentPaddingFormFields,
                      border: borderFormFields),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (birthDate) {
                    if (birthDate == null || birthDate.isEmpty) {
                      return 'Por favor, adicione uma data';
                    }
                    return null;
                  },
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      widget.store.birthDateController.text =
                          selectedDate.toString();
                    }
                  },
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xFFADF5F1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: () async {
                if (widget.store.formKey.currentState!.validate()) {
                  await widget.store.createKid(
                    widget.store.nameController.text,
                    widget.store.birthDateController.text,
                  );
                  if (widget.store.state is ErrorCreateKidState) {
                    ErrorCreateKidEntity error =
                        (widget.store.state as ErrorCreateKidState).error;
                    if (error.name.isNotEmpty) {
                      setState(() {
                        nameError = error.name;
                      });
                    }
                    if (error.birthDate.isNotEmpty) {
                      setState(() {
                        birthDateError = error.birthDate;
                      });
                    }
                  }
                }
              },
              child: const Text('Criar usuário'),
            ),
          ],
        ));
  }
}
