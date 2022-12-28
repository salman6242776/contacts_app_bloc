import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';
import 'package:flutter/material.dart';

class AddEditContactScreen extends StatelessWidget {
  static const routeName = '/add_edit_contact_screen';

  ContactDataModel? contactDataModel;
  final _form = GlobalKey<FormState>();

  AddEditContactScreen({super.key});

  bool get isEdit => contactDataModel != null && contactDataModel?.id != null;
  bool get isNameValid =>
      contactDataModel != null && contactDataModel?.name.isNotEmpty == true;

  String get _getAppBarTitle => isEdit ? "Edit Contact" : "Add New Contact";

  void onSaveClickListener(BuildContext context) {
    final isValid = _form.currentState?.validate();
    if (isValid == true) {
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill required details")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    contactDataModel =
        ModalRoute.of(context)?.settings.arguments as ContactDataModel? ??
            ContactDataModel();
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle),
        actions: [
          IconButton(
            onPressed: () {
              onSaveClickListener(context);
            },
            icon: Icon(isEdit ? Icons.update : Icons.save),
          ),
          if (isEdit)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              getFormTextField(
                  initalValue: contactDataModel?.name ?? "",
                  label: "Name",
                  errorMessage: "Please enter name",
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  toUpdate: (value) {
                    contactDataModel?.name = value;
                  }),
              getFormTextField(
                  initalValue: contactDataModel?.name ?? "",
                  label: "Mobile#",
                  errorMessage: "Please enter mobile number",
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  toUpdate: (value) {
                    contactDataModel?.mobileNumber = value;
                  }),
              getFormTextField(
                  initalValue: contactDataModel?.name ?? "",
                  label: "Landline#",
                  errorMessage: "Please enter landline number",
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  toUpdate: (value) {
                    contactDataModel?.mobileNumber = value;
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget getFormTextField(
      {required String initalValue,
      required String label,
      required String errorMessage,
      required TextInputType textInputType,
      required TextInputAction textInputAction,
      required Function toUpdate}) {
    return TextFormField(
      initialValue: initalValue, //contactDataModel?.name ?? "",
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText: label, //"Name",
      ),
      textInputAction: textInputAction,
      validator: (value) {
        if (isNameValid) {
          return null;
        } else {
          return errorMessage; //"Please enter name";
        }
      },
      onChanged: (value) {
        toUpdate(value);
      },
    );
  }
}
