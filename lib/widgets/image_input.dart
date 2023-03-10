import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final void Function(File?) onSelectImage;

  const ImageInput({Key? key, required this.onSelectImage}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    var imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if(imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 100,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No image provided',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 10.0, 10.0, 10.0),
            child: ElevatedButton.icon(
              onPressed: _takePicture,
              icon: const Icon(Icons.camera),
              label: const Text('Take picture'),
            ),
          ),
        )
      ],
    );
  }
}
