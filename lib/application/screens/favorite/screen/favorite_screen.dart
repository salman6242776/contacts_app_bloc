import 'package:contact_app_bloc_architecture/application/screens/contact_list/widgets/contact_list_item.dart';
import 'package:contact_app_bloc_architecture/application/screens/favorite/bloc/favorite_bloc.dart';
import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/favorite';
  FavoriteScreen({super.key}) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Contacts"),
      ),
      body: BlocProvider<FavoriteBloc>(
          create: (context) => FavoriteBloc()..add(const FetchFavoriteEvent()),
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (blocContext, state) {
              if (state is FetchFavoriteStarted) {
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                  itemBuilder: ((context, index) {
                    return ContactListItem(
                        contactDataModel:
                            state.props[index] as ContactDataModel,
                        onItemClickListener: () {});
                  }),
                  itemCount: state.props.length,
                );
              }
            },
          )),
    );
  }
}
