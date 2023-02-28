import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';
import 'package:contact_app_bloc_architecture/presentation/app_drawer.dart';
import 'package:contact_app_bloc_architecture/presentation/components/dialog/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../presentation/screens/contact_list/bloc/contact_list_bloc.dart';
import '../../../../presentation/screens/contact_list/widgets/contact_list_item.dart';
import '../../crud_contact/screen/crud_contact_screen.dart';

// import '../link_screen_and_block.dart';

class ContactListScreen extends StatelessWidget {
  final ContactListBloc _contactListBloc = ContactListBloc();

  ContactListScreen({super.key});

  void _getAllContacts() {
    _contactListBloc
        .add(ContactListFetchCompletedEvent(contactDataModelList: []));
  }

  @override
  Widget build(BuildContext context) {
    _getAllContacts();
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Contact List"),
      ),
      body: BlocBuilder(
        bloc: _contactListBloc,
        builder: (context, state) {
          if (state is ContactListStateFetchStarted) {
            return getCenteredProgressCircularIndicator();
          } else if (state is ContactListStateFetchCompletedWithError) {
            return AppDialog.getOneButtonAlertDialog(
                buildContext: context,
                title: "Error",
                content: state.errorMessage,
                rightButtonText: "Ok",
                rightButtonClickListener: () {});
          } else if (state is ContactListStateFetchCompletedSuccessfully) {
            return getListView(context, state.contactDataModelList);
          } else {
            return Container();
          }
        },
        // buildWhen: (previous, current) {
        //   return previous.runtimeType != current.runtimeType;
        // },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(CRUDContactScreen.routeName)
              .then((value) => _getAllContacts());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget getListView(
      BuildContext context, List<ContactDataModel> contactDataModelList) {
    return contactDataModelList.isEmpty
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
                      .pushNamed(CRUDContactScreen.routeName)
                      .then((value) => _getAllContacts());
                },
                child: const Text("Add New Contact"),
              )
            ],
          )
        : ListView.builder(
            itemBuilder: ((context, index) {
              return ContactListItem(
                  contactDataModel: contactDataModelList[index],
                  onItemClickListener: (selectedContact) {
                    Navigator.of(context)
                        .pushNamed(CRUDContactScreen.routeName,
                            arguments: selectedContact)
                        .then((value) => _getAllContacts());
                  });
            }),
            itemCount: contactDataModelList.length,
          );
  }

  Widget getCenteredProgressCircularIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
