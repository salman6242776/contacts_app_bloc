import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectAndPreviewImage extends StatefulWidget {
  String? imageFilePath;
  final Function profilePictureSelectCallback;

  SelectAndPreviewImage(
      {super.key,
      this.imageFilePath,
      required this.profilePictureSelectCallback});

  String? get selectedImagePath {
    return imageFilePath;
  }

  // void setImagePath(String path) {
  //   imageFilePath = path;
  // }

  @override
  State<SelectAndPreviewImage> createState() => _SelectAndPreviewImageState();
}

class _SelectAndPreviewImageState extends State<SelectAndPreviewImage> {
  void setImage(String? image) {
    if (image != null && image.isNotEmpty) {
      setState(() {
        widget.imageFilePath = image;
      });
      widget.profilePictureSelectCallback(image);
    }
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
            child: widget.imageFilePath?.isNotEmpty == true
                ? Image.file(
                    File(widget.imageFilePath ?? ""),
                    fit: BoxFit.cover,
                  )
                : const Center(
                    child: Text(
                      "Image",
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
          TextButton(
            onPressed: () async {
              await ImagePicker()
                  .pickImage(source: ImageSource.gallery)
                  .then((value) => setImage(value?.path));
            },
            child: const Text("Select Image"),
          ),
        ],
      ),
    );
  }
}
