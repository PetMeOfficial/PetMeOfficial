import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:petme/models/user.dart' as model;
import '../../../../Authentication/auth_page.dart';
import '../../../../providers/user_provider.dart';
import '../../../../utils/utils.dart';

class BlogPost {
  final String title;
  final String description;
  final String content;

  BlogPost({required this.title, required this.description, required this.content});
}

class CreateBlogPage extends StatefulWidget {
  const CreateBlogPage({super.key});

  @override
  _CreateBlogPageState createState() => _CreateBlogPageState();
}

class _CreateBlogPageState extends State<CreateBlogPage> {
  var authController = AuthPage.instance;

  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _content = '';
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final contentController = TextEditingController();
  Uint8List? _image;


  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF487776),
        title: const Text('Create Blog Post'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                        radius: 84,
                        backgroundImage: MemoryImage(_image!),
                        backgroundColor: Colors.red,
                      )
                          :  const CircleAvatar(
                        radius: 64,
                        backgroundImage: AssetImage('assets/upload3.png'),
                        backgroundColor:Color(0xFF71B6B3),
                      ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                      labelStyle: const TextStyle(color: Color(0xFF487776)),
                      prefixIcon: const Icon(
                        Icons.edit,
                        color: Color(0xFF487776),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide: const BorderSide(
                            width: 2.0, color: Color(0xFF487776)),
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                      labelStyle: const TextStyle(color: Color(0xFF487776)),
                      prefixIcon: const Icon(
                        Icons.edit,
                        color: Color(0xFF487776),
                      ),
                      // hintText: 'Password',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide: const BorderSide(
                            width: 2.0, color: Color(0xFF487776)),
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: contentController,
                  decoration: InputDecoration(
                    labelText: 'Content',
                    contentPadding: const EdgeInsets.symmetric(vertical: 60.0),
                    labelStyle: const TextStyle(color: Color(0xFF487776)),
                    prefixIcon: const Icon(
                      Icons.edit,
                      color: Color(0xFF487776),
                    ),
                    // hintText: 'Password',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: const BorderSide(
                          width: 2.0, color: Color(0xFF487776)),
                    )
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the blog content';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _content = value!;
                    });
                  },
                ),
                const SizedBox(height: 26.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final blogPost = BlogPost(
                        title: _title,
                        description: _description,
                        // imageUrl: _imageUrl,
                        content: _content,
                      );
                      authController.CreateblogPost(
                        titleController.text,
                        descriptionController.text,
                        contentController.text,
                        user.username,
                        user.profilePicUrl,
                        _image!,
                      );
                      if (kDebugMode) {
                        print("object");
                      }

                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                    const EdgeInsets.fromLTRB(85, 10, 85, 10),
                    backgroundColor: const Color(0xFF487776),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10.0)),
                  ),
                  child: const Text(
                      'Publish', style: TextStyle(fontSize: 23),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}