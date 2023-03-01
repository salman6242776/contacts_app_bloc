import 'package:contact_app_bloc_architecture/common/di/get_it.dart';
import 'package:contact_app_bloc_architecture/presentation/screens/crud_contact/bloc/crud_contact_bloc.dart';
import 'package:contact_app_bloc_architecture/presentation/screens/contact_list/bloc/contact_list_bloc.dart';
import 'package:contact_app_bloc_architecture/presentation/screens/favorite/screen/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './presentation/screens/contact_list/screen/contact_list_screen.dart';
import 'presentation/screens/crud_contact/screen/crud_contact_screen.dart';

void main() {
  setUpGetIt();
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
        fontFamily: "Raleway",
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.orange),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        drawerTheme: const DrawerThemeData(elevation: 100),
        textTheme: const TextTheme(
          // title medium for list item tile.
          titleMedium: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ContactListBloc(),
          ),
          BlocProvider(
            create: ((context) => CRUDContactBloc()),
          )
        ],
        child: ContactListScreen(),
      ),
      routes: {
        CRUDContactScreen.routeName: (_) => CRUDContactScreen(),
        FavoriteScreen.routeName: (_) => FavoriteScreen()
      },
    );
  }
}
