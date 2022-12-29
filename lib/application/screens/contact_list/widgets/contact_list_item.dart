import 'dart:io';

import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';
import 'package:flutter/material.dart';

class ContactListItem extends StatelessWidget {
  final ContactDataModel contactDataModel;
  final Function onItemClickListener;
  const ContactListItem(
      {super.key,
      required this.contactDataModel,
      required this.onItemClickListener});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.file(
              File(contactDataModel.profilePicture),
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Text(contactDataModel.name),
        subtitle: Text(contactDataModel.mobileNumber),
        onTap: () {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('clicked: ${contactDataModel.name}')),
          // );
          onItemClickListener(contactDataModel);
        },
      ),
    );
  }
}
