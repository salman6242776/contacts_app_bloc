import 'package:contact_app_bloc_architecture/presentation/components/dialog/app_dialogs.dart';
import 'package:contact_app_bloc_architecture/presentation/screens/crud_contact/bloc/crud_contact_bloc.dart';
import 'package:contact_app_bloc_architecture/presentation/screens/crud_contact/widgets/select_and_preview_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/custom_text_form_field.dart';
import 'package:contact_app_bloc_architecture/data/model/contact_data_model.dart';

class CRUDContactScreen extends StatelessWidget {
  static const routeName = '/add_edit_contact_screen';
  final CRUDContactBloc _crudContactBloc = CRUDContactBloc();

  ContactDataModel? contactDataModel;

  final _form = GlobalKey<FormState>();

  CRUDContactScreen({super.key});

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
      if (contactDataModel?.id != null) {
        _crudContactBloc.add(UpdateContactEvent(contactDataModel!));
      } else {
        _crudContactBloc.add(CreateContactEvent(contactDataModel!));
      }
    }
  }

  void onDeleteClickListener(BuildContext context) {
    if (contactDataModel?.id != null) {
      showDialog(
          context: context,
          builder: ((_) => AppDialog.getTwoButtonAlertDialog(
                buildContext: context,
                title: "ContactApp",
                content: "Are you sure you want to delete this item?",
                leftButtonText: "No",
                rightButtonText: "Yes",
                leftButtonClickListener: () {},
                rightButtonClickListener: () {
                  _crudContactBloc.add(DeleteContactEvent(contactDataModel!));
                },
              )));
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("No User found!")));
    }
  }

  void toggleFavoriteOnClickListener(BuildContext context) {
    if (contactDataModel?.id != null) {
      _crudContactBloc.add(ToggleFavoriteContactEvent(contactDataModel!));
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("No User found!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    contactDataModel =
        ModalRoute.of(context)?.settings.arguments as ContactDataModel? ??
            ContactDataModel();
    if (contactDataModel?.id != null) {
      print("----------------------EDIT-----------------");
    }

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
              onPressed: () {
                onDeleteClickListener(context);
              },
              icon: const Icon(Icons.delete),
            ),
          if (isEdit)
            BlocBuilder(
              bloc: _crudContactBloc,
              builder: (context, state) {
                print("CRUDContactScreen Builder called");
                return IconButton(
                    onPressed: () {
                      toggleFavoriteOnClickListener(context);
                    },
                    icon: Icon(isEdit && contactDataModel?.isFavorite == true
                        ? Icons.star
                        : Icons.star_border));
              },
              buildWhen: (previous, current) =>
                  previous.runtimeType != current.runtimeType,
            ),
        ],
      ),
      body: BlocProvider<CRUDContactBloc>(
        create: (ctx) => _crudContactBloc,
        child: blockProviderChild(),
      ),
    );
  }

  Widget blockProviderChild() {
    return BlocListener<CRUDContactBloc, CRUDContactState>(
      listener: ((context, state) {
        if (state is ShowLoaderState) {
          const CircularProgressIndicator();
        } else if (state is CreateCompletedState ||
            state is UpdateCompletedState ||
            state is DeleteCompletedState) {
          Navigator.of(context).pop();
        } else if (state is ToggleFavoriteContactCompletedState) {
          contactDataModel?.isFavorite =
              !(contactDataModel?.isFavorite ?? true);
        }
      }),
      child: Padding(
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
                  initalValue: contactDataModel?.mobileNumber ?? "",
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
                  initalValue: contactDataModel?.landlineNumber ?? "",
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
                  imageFilePath: contactDataModel?.profilePicture,
                  profilePictureSelectCallback: (imagePath) {
                    profilePictureSelectCallback(imagePath);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
