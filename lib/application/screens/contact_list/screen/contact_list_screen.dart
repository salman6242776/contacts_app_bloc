import 'package:path/path.dart';

import '../../../../application/screens/contact_list/bloc/contact_list_bloc.dart';
import '../../../../application/screens/contact_list/widgets/contact_list_item.dart';
import '../../add_or_edit_contact/screen/add_edit_contact_screen.dart';
import '../../../../data/model/contact_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../link_screen_and_block.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
      ),
      body: BlocProvider(
        create: (_) => ContactListBloc(),
        child: BlocBuilder<ContactListBloc, List<ContactDataModel>>(
          builder: (context, state) {
            return getListView(context);
          },
          // buildWhen: (previous, current) =>
          //     current.runtimeType != previous.runtimeType,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddEditContactScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget getListView(BuildContext context) {
    List<ContactDataModel> list = context
        .select((ContactListBloc contactListBloc) => contactListBloc.state);
    return list.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  "No Data is available. Please click button to add new contact.",
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AddEditContactScreen.routeName);
                },
                child: const Text("Add New Contact"),
              )
            ],
          )
        : ListView.builder(
            itemBuilder: ((context, index) {
              return ContactListItem(
                  contactDataModel: list[index],
                  onItemClickListener: (selectedContact) {
                    Navigator.of(context).pushNamed(
                        AddEditContactScreen.routeName,
                        arguments: selectedContact);
                  });
            }),
            itemCount: list.length,
          );
  }
}
