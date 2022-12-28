import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/screens/contact_list/bloc/contact_list_bloc.dart';
import '../../../../application/screens/contact_list/widgets/contact_list_item.dart';
import '../../add_or_edit_contact/screen/add_edit_contact_screen.dart';

// import '../link_screen_and_block.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  late ContactListBloc _contactListBloc;

  @override
  void initState() {
    _contactListBloc = ContactListBloc();
    _getAllContacts();
    super.initState();
  }

  void _getAllContacts() {
    _contactListBloc
        .add(ContactListFetchCompletedEvent(contactDataModelList: []));
  }

  @override
  void dispose() {
    _contactListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
      ),
      body: BlocBuilder(
        bloc: _contactListBloc,
        builder: (context, state) {
          return getListView(context);
        },
        // buildWhen: (previous, current) {
        //   return previous.runtimeType != current.runtimeType;
        // },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(AddEditContactScreen.routeName)
              .then((value) => _getAllContacts());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget getListView(BuildContext context) {
    return _contactListBloc.state.isEmpty
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
                      .pushNamed(AddEditContactScreen.routeName)
                      .then((value) => _getAllContacts());
                },
                child: const Text("Add New Contact"),
              )
            ],
          )
        : ListView.builder(
            itemBuilder: ((context, index) {
              return ContactListItem(
                  contactDataModel: _contactListBloc.state[index],
                  onItemClickListener: (selectedContact) {
                    Navigator.of(context)
                        .pushNamed(AddEditContactScreen.routeName,
                            arguments: selectedContact)
                        .then((value) => _getAllContacts());
                  });
            }),
            itemCount: _contactListBloc.state.length,
          );
  }
}
