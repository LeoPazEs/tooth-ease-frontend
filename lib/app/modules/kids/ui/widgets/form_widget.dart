import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:tooth_ease_frontend/app/modules/kids/data/entities/error_entities.dart';
import 'package:tooth_ease_frontend/app/modules/kids/data/entities/kid_entities.dart';
import 'package:tooth_ease_frontend/app/modules/shared/mask.dart';

import '../../interactor/states/kids_state.dart';
import '../../interactor/stores/kids_store.dart';
import 'confirm_delete_widget.dart';

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
                    errorText: nameError.isNotEmpty ? nameError : null,
                    errorMaxLines: 3,
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
              child: Observer(
                builder: (_) => TextFormField(
                  inputFormatters: [Mask().maskData],
                  readOnly: true,
                  onTap: () async {
                    await widget.store
                        .selectDate(context, widget.store.dataController);
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.01,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: "Data de nascimento",
                    hintText: "Clique para selecionar...",
                    errorText:
                        birthDateError.isNotEmpty ? birthDateError : null,
                    errorMaxLines: 3,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        await widget.store
                            .selectDate(context, widget.store.dataController);
                      },
                    ),
                  ),
                  controller: widget.store.dataController,
                ),
              ),
            ),
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
                    widget.store.dataController.text,
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
                  } else {
                    if (!mounted) {
                      return;
                    }
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text('Criar Criança'),
            ),
          ],
        ));
  }
}

class EditKidFormWidget extends StatefulWidget {
  final KidsStore store;
  final CompleteKidEntity kid;
  const EditKidFormWidget({super.key, required this.store, required this.kid});

  @override
  State<EditKidFormWidget> createState() => _EditKidFormWidgetState();
}

class _EditKidFormWidgetState extends State<EditKidFormWidget> {
  String nameError = "";
  String birthDateError = "";

  @override
  void initState() {
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    widget.store.editDataController.text =
        inputFormat.format(widget.kid.birthDate);
    widget.store.editNameController.text = widget.kid.name;
    super.initState();
  }

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
        key: widget.store.editFormKey,
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
                    errorText: nameError.isNotEmpty ? nameError : null,
                    errorMaxLines: 3,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (nome) {
                    if (nome == null || nome.isEmpty) {
                      return 'Por favor, insira um nome';
                    }
                    return null;
                  },
                  controller: widget.store.editNameController,
                  onChanged: (value) {
                    setState(() {
                      nameError = '';
                    });
                  },
                )),
            Padding(
              padding: paddingFormFields,
              child: Observer(
                builder: (_) => TextFormField(
                  inputFormatters: [Mask().maskData],
                  readOnly: true,
                  onTap: () async {
                    await widget.store
                        .selectDate(context, widget.store.editDataController);
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.01,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: "Data de nascimento",
                    hintText: "Clique para selecionar...",
                    errorText:
                        birthDateError.isNotEmpty ? birthDateError : null,
                    errorMaxLines: 3,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        await widget.store.selectDate(
                            context, widget.store.editDataController);
                      },
                    ),
                  ),
                  controller: widget.store.editDataController,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xFFADF5F1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: () async {
                if (widget.store.editFormKey.currentState!.validate()) {
                  await widget.store.editKid(
                    widget.kid.id,
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
                  } else {
                    if (!mounted) {
                      return;
                    }
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text('Alterar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: () async {
                if (!mounted) {
                  return;
                }
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      surfaceTintColor: Colors.transparent,
                      backgroundColor: Colors.white,
                      title: const Icon(Icons.face_6, size: 50),
                      content: ConfirmDeleteWidget(kid: widget.kid),
                    );
                  },
                );
              },
              child: const Text('Excluir'),
            ),
          ],
        ));
  }
}
