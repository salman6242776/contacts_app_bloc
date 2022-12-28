import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';
import 'package:flutter/material.dart';

class AddEditContactScreen extends StatelessWidget {
  static const routeName = '/add_edit_contact_screen';
  ContactDataModel? contactDataModel;

  String get _getAppBarTitle =>
      contactDataModel == null ? "Add New Contact" : "Edit Contact";

  @override
  Widget build(BuildContext context) {
    contactDataModel =
        ModalRoute.of(context)?.settings.arguments as ContactDataModel?;
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle),
      ),
    );
  }
}
