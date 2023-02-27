import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPosts extends StatefulWidget {
  const UploadPosts({Key? key}) : super(key: key);

  @override
  State<UploadPosts> createState() => _UploadPostsState();
}

class _UploadPostsState extends State<UploadPosts> {
  Uint8List? _file;

  pickImage(ImageSource source) async {
    final ImagePicker _imagepicker = ImagePicker();
    XFile? _file = await _imagepicker.pickImage(source: source);

    if(_file != null){
      return await _file.readAsBytes();
    }
    debugPrint("No Image Selected");
  }

  selectImage(parentContext){
    return showDialog(
        context: parentContext,
        builder: (context){
          return SimpleDialog(
            title: const Text("Create Post"),
            children: <Widget>[
              SimpleDialogOption(
                onPressed:  () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
                child: const Text("from Camera"),
              ),
              SimpleDialogOption(
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
                child: const Text("from Gallery"),
              ),
              SimpleDialogOption(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          child: const Text(
            "Upload Image" ,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black87
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.camera_alt),
          iconSize: 50,
          color: Colors.pink,
          onPressed: (){},
        )
      ],
    );
  }
}
