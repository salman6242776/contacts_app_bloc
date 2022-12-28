import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectAndPreviewImage extends StatefulWidget {
  XFile? _imageFile;
  SelectAndPreviewImage({super.key});

  String? get selectedImagePath {
    return _imageFile?.path;
  }

  @override
  State<SelectAndPreviewImage> createState() => _SelectAndPreviewImageState();
}

class _SelectAndPreviewImageState extends State<SelectAndPreviewImage> {
  void setImage(XFile? image) {
    setState(() {
      widget._imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
              // image: DecorationImage(
              //   image: imageFile != null? Image.file(File(imageFile?.path ?? "") :  NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: widget._imageFile != null
                ? Image.file(
                    File(widget._imageFile?.path ?? ""),
                    fit: BoxFit.cover,
                  )
                : const Text(
                    "Image",
                    textAlign: TextAlign.center,
                  ),
          ),
          TextButton(
            onPressed: () async {
              await ImagePicker()
                  .pickImage(source: ImageSource.gallery)
                  .then((value) => setImage(value));
            },
            child: const Text("Select Image"),
          ),
        ],
      ),
    );
  }
}
