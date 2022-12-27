import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';
import 'package:flutter/material.dart';

class ContactListItem extends StatelessWidget {
  final ContactDataModel contactDataModel;
  const ContactListItem({super.key, required this.contactDataModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: const CircleAvatar(
          child: Text("Lead"),
        ),
        title: Text(contactDataModel.name),
        subtitle: Text(contactDataModel.mobileNumber),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('clicked: ${contactDataModel.name}')),
          );
        },
      ),
    );
  }
}
