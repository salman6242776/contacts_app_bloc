import 'package:flutter/material.dart';

import './application/screens/contact_list/screen/contact_list_screen.dart';
import 'application/screens/add_or_edit_contact/screen/add_edit_contact_screen.dart';
// import './application/contact_list/link_screen_and_block.dart';
import 'package:contact_app_bloc_architecture/common/database_configuration.dart';
import 'package:contact_app_bloc_architecture/helpers/db_helper.dart';

void main() {
  runApp(const MyApp());

  // DbHelper.insert(
  //   TblContactsConfigration.tblName,

  //   // {TblContactsConfigration.id : } ,
  //   {
  //     TblContactsConfigration.name: "Salman",
  //     TblContactsConfigration.mobileNumber: "11111111",
  //     TblContactsConfigration.landlineNumber: "123456",
  //     TblContactsConfigration.isFavorite: 0,
  //     TblContactsConfigration.profilePicture: ''
  //   },
  // );
}
// void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const ContactListScreen(),
      routes: {
        '/': (_) => const ContactListScreen(),
        AddEditContactScreen.routeName: (_) => AddEditContactScreen()
      },
    );
  }
}
