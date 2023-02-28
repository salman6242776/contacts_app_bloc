import 'package:contact_app_bloc_architecture/presentation/screens/crud_contact/screen/crud_contact_screen.dart';
import 'package:contact_app_bloc_architecture/presentation/screens/favorite/screen/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppDrawer extends Drawer {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        AppBar(
          title: const Text("Drawer"),
          automaticallyImplyLeading: false,
        ),
        _getListTileSlab(
            context: context,
            iconData: Icons.list,
            title: "All Contacts",
            onTapClickListener: () {
              Navigator.of(context).pushReplacementNamed("/");
            }),
        _getListTileSlab(
            context: context,
            iconData: Icons.favorite,
            title: "Favorite Contacts",
            onTapClickListener: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(FavoriteScreen.routeName);
            }),
        _getListTileSlab(
            context: context,
            iconData: Icons.add,
            title: "Add New Contact",
            onTapClickListener: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(CRUDContactScreen.routeName);
            }),
      ],
    ));
  }

  Widget _getListTileSlab(
      {required BuildContext context,
      required IconData iconData,
      required String title,
      required Function onTapClickListener}) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(title),
      onTap: (() => onTapClickListener()),
    );
  }
}
