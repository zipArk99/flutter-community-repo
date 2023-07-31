
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(String error, BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(error),
      ),
    );
}

void showSnakeBar() {}
Future<FilePickerResult?> pickImage() async {
  final result = await FilePicker.platform.pickFiles(type: FileType.image);
  return result;
}
