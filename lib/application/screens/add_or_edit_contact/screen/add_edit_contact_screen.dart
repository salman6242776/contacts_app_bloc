import 'package:contact_app_bloc_architecture/application/screens/add_or_edit_contact/widgets/select_and_preview_image.dart';
import 'package:flutter/material.dart';

import '../../../components/custom_text_form_field.dart';
import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';

class AddEditContactScreen extends StatelessWidget {
  static const routeName = '/add_edit_contact_screen';

  ContactDataModel? contactDataModel;

  final _form = GlobalKey<FormState>();
  final selectAndPreviewImage = SelectAndPreviewImage();

  AddEditContactScreen({super.key});

  bool get isEdit => contactDataModel != null && contactDataModel?.id != null;
  bool get _isNameValid =>
      contactDataModel != null && contactDataModel?.name.isNotEmpty == true;

  bool get _isMobileNumberValid =>
      contactDataModel != null &&
      contactDataModel?.mobileNumber.isNotEmpty == true;

  bool get _isLandlineNumberValid =>
      contactDataModel != null &&
      contactDataModel?.landlineNumber.isNotEmpty == true;

  String get _getAppBarTitle => isEdit ? "Edit Contact" : "Add New Contact";

  void onSaveClickListener(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final isValid = _form.currentState?.validate();
    if (isValid == true) {
      if (selectAndPreviewImage.selectedImagePath != null) {
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select profile picture")),
        );
      }
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
              CustomTextFormField(
                  initalValue: contactDataModel?.name ?? "",
                  label: "Name",
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    return _isNameValid ? null : "Please enter name";
                  },
                  toUpdate: (value) {
                    contactDataModel?.name = value;
                  }),
              CustomTextFormField(
                  initalValue: contactDataModel?.name ?? "",
                  label: "Mobile#",
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    return _isMobileNumberValid
                        ? null
                        : "Please enter mobile number";
                  },
                  toUpdate: (value) {
                    contactDataModel?.mobileNumber = value;
                  }),
              CustomTextFormField(
                  initalValue: contactDataModel?.name ?? "",
                  label: "Landline#",
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    return _isLandlineNumberValid
                        ? null
                        : "Please enter landline number";
                  },
                  toUpdate: (value) {
                    contactDataModel?.landlineNumber = value;
                  }),
              selectAndPreviewImage,
            ],
          ),
        ),
      ),
    );
  }
}
