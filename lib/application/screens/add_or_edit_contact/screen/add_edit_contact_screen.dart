import 'dart:async';

import 'package:contact_app_bloc_architecture/application/screens/add_or_edit_contact/bloc/add_edit_contact_bloc.dart';
import 'package:contact_app_bloc_architecture/application/screens/add_or_edit_contact/widgets/select_and_preview_image.dart';
import 'package:contact_app_bloc_architecture/common/database_configuration.dart';
import 'package:contact_app_bloc_architecture/helpers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/custom_text_form_field.dart';
import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';

class AddEditContactScreen extends StatefulWidget {
  static const routeName = '/add_edit_contact_screen';
  AddEditContactScreen({super.key});

  @override
  State<AddEditContactScreen> createState() => _AddEditContactScreenState();
}

class _AddEditContactScreenState extends State<AddEditContactScreen> {
  late AddEditContactBloc _addEditContactBloc;
  late StreamSubscription blocSubscription;
  // = AddEditContactBloc();
  ContactDataModel? contactDataModel;

  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    _addEditContactBloc = AddEditContactBloc();

    blocSubscription = _addEditContactBloc.stream.listen((receivedState) {
      if (receivedState is CreateCompletedState) {
        Navigator.of(context).pop();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    blocSubscription.cancel();
    _addEditContactBloc.close();
    super.dispose();
  }

  void profilePictureSelectCallback(String imagePath) {
    contactDataModel?.profilePicture = imagePath;
  }

  bool get isEdit => contactDataModel != null && contactDataModel?.id != null;

  bool get _isNameValid =>
      contactDataModel != null && contactDataModel?.name.isNotEmpty == true;

  bool get _isMobileNumberValid =>
      contactDataModel != null &&
      contactDataModel?.mobileNumber.isNotEmpty == true;

  bool get _isLandlineNumberValid =>
      contactDataModel != null &&
      contactDataModel?.landlineNumber.isNotEmpty == true;

  String get _getAppBarTitle => isEdit ? "Edit Contact" : "Add New Contact";

  bool _isViewIsValid(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final isValid = _form.currentState?.validate();
    if (isValid == true) {
      if (contactDataModel?.profilePicture.isNotEmpty == true) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select profile picture")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill required details")),
      );
    }
    return false;
  }

  void onSaveClickListener(BuildContext context) {
    if (_isViewIsValid(context)) {
      _addEditContactBloc.add(CreateUserEvent(contactDataModel!));
    }
  }

  @override
  Widget build(BuildContext context) {
    contactDataModel =
        ModalRoute.of(context)?.settings.arguments as ContactDataModel? ??
            ContactDataModel();

    return Scaffold(
        appBar: AppBar(
          title: Text(_getAppBarTitle),
          actions: [
            IconButton(
              onPressed: () {
                onSaveClickListener(context);
              },
              icon: Icon(isEdit ? Icons.update : Icons.save),
            ),
            if (isEdit)
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
              ),
          ],
        ),
        body: BlocBuilder(
          bloc: _addEditContactBloc,
          builder: (context, state) {
            return blockProviderChild(context);
          },
        )
        // BlocProvider(
        //     create: (context) => AddEditContactBloc(),
        //     child: BlocBuilder<AddEditContactBloc, AddEditContactState>(
        //       builder: (context, state) {
        //         return blockProviderChild(context);
        //       },
        //     )),
        );
  }

  Widget blockProviderChild(BuildContext context) {
    // AddEditContactState addEditContactState =
    //     context.select(((AddEditContactBloc addEditContactBloc) {
    //   _addEditContactBloc = addEditContactBloc;
    //   return addEditContactBloc.state;
    // }));

    // if (addEditContactState is CreateCompletedState) {
    //   Navigator.of(context).pop();
    // }

    return _addEditContactBloc.state == ShowLoaderState()
        ? CircularProgressIndicator()
        : Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _form,
              child: ListView(
                children: [
                  CustomTextFormField(
                      initalValue: contactDataModel?.name ?? "",
                      label: "Name",
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        return _isNameValid ? null : "Please enter name";
                      },
                      toUpdate: (value) {
                        contactDataModel?.name = value;
                      }),
                  CustomTextFormField(
                      initalValue: contactDataModel?.name ?? "",
                      label: "Mobile#",
                      textInputType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        return _isMobileNumberValid
                            ? null
                            : "Please enter mobile number";
                      },
                      toUpdate: (value) {
                        contactDataModel?.mobileNumber = value;
                      }),
                  CustomTextFormField(
                      initalValue: contactDataModel?.name ?? "",
                      label: "Landline#",
                      textInputType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        return _isLandlineNumberValid
                            ? null
                            : "Please enter landline number";
                      },
                      toUpdate: (value) {
                        contactDataModel?.landlineNumber = value;
                      }),
                  SelectAndPreviewImage(
                      profilePictureSelectCallback: (imagePath) {
                    profilePictureSelectCallback(imagePath);
                  }),
                ],
              ),
            ),
          );
  }
}
