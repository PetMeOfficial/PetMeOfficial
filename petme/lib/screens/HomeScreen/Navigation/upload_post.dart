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
    final ImagePicker imagepicker = ImagePicker();
    XFile? file = await imagepicker.pickImage(source: source);

    if(file != null){
      return await file.readAsBytes();
    }
    debugPrint("No Image Selected");
  }

  selectImage(parentContext){
    return showDialog(
        context: parentContext,
        builder: (context){
          return SimpleDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 1,
            backgroundColor: Colors.black87,
            title: const Text(
              "Create Post",style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed:  () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
                child: const Text("From Camera",style: TextStyle(fontSize: 20,color: Colors.white),),
              ),
              SimpleDialogOption(
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: const Text("From Gallery",style: TextStyle(fontSize: 20,color: Colors.white),),
              ),
              SimpleDialogOption(
                child: const Text("Cancel",style: TextStyle(fontSize: 20,color: Colors.white),),
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
          onPressed: () => selectImage(context),
        )
      ],
    );
  }
}
