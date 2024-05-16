import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tooth_ease_frontend/app/modules/shared/mask.dart';

import '../../interactor/stores/profile_store.dart';

class ProfileFormWidget extends StatefulWidget {
  const ProfileFormWidget({super.key, required this.store});
  final ProfileStore store;

  @override
  State<ProfileFormWidget> createState() => _ProfileFormWidgetState();
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
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
          children: [
            Padding(
                padding: paddingFormFields,
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Primeiro Nome',
                      contentPadding: contentPaddingFormFields,
                      border: borderFormFields),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (firstName) =>
                      firstName == null || firstName.isEmpty
                          ? 'Por favor, insira um primeiro nome'
                          : null,
                  controller: widget.store.firstNameController,
                )),
            Padding(
                padding: paddingFormFields,
                child: TextFormField(
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      labelText: 'Ultimo Nome',
                      contentPadding: contentPaddingFormFields,
                      border: borderFormFields),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (lastName) => lastName == null || lastName.isEmpty
                      ? 'Por favor, insira um último nome'
                      : null,
                  controller: widget.store.lastNameController,
                )),
            Padding(
              padding: paddingFormFields,
              child: Observer(
                builder: (_) => TextFormField(
                  inputFormatters: [Mask().maskData],
                  readOnly: true,
                  onTap: () async {
                    await widget.store
                        .selectDate(context, widget.store.birthDateController);
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
                    errorMaxLines: 3,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        await widget.store.selectDate(
                            context, widget.store.birthDateController);
                      },
                    ),
                  ),
                  controller: widget.store.birthDateController,
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
                  await widget.store.editProfile();
                }
              },
              child: const Text('Alterar'),
            ),
          ],
        ));
  }
}
