import 'package:contact_app_bloc_architecture/application/contact_list/bloc/contact_list_bloc.dart';
import 'package:contact_app_bloc_architecture/application/contact_list/widgets/contact_list_item.dart';
import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';
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
        lazy: false,
        create: (_) => ContactListBloc(),
        child: BlocBuilder<ContactListBloc, List<ContactDataModel>>(
          builder: (context, state) {
            return getListView(context);
          },
          // buildWhen: (previous, current) =>
          //     current.runtimeType != previous.runtimeType,
        ),
      ),
    );
  }

  Widget getListView(BuildContext context) {
    List<ContactDataModel> list = context
        .select((ContactListBloc contactListBloc) => contactListBloc.state);
    return ListView.builder(
      itemBuilder: ((context, index) {
        return ContactListItem(contactDataModel: list[index]);
      }),
      itemCount: list.length,
    );
  }
}
