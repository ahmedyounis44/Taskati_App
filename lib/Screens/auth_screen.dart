import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/Services/validator_service.dart';
import 'package:flutter_tasks_app/Widgets/customButton.dart';
import 'package:image_picker/image_picker.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? photo;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController NameController = TextEditingController();

  void getImageFromCamera() async {
    photo = await picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  void getImageFromGallery() async {
    photo = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            photo == null
                ? CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 100,
                    child: (Icon(
                      Icons.person,
                      size: 150,
                      color: Colors.deepPurple,
                    )),
                  )
                : CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 100,
                    backgroundImage: Image.file(File(photo?.path ?? "")).image,
                  ),
            SizedBox(height: 20),
            Custombutton(
              name: "Upload From Camera",
              onPressed: () {
                getImageFromCamera();
              },
            ),
            SizedBox(height: 20),
            Custombutton(
              name: "Upload From Gallery",
              onPressed: () {
                getImageFromGallery();
              },
            ),

            SizedBox(height: 30),
            Divider(height: 2),
            SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  /// EMAIL
                  TextFormField(
                    controller: NameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.name,
                    validator: ValidatorService.validateName,
                  ),

                  const SizedBox(height: 20),

                  Custombutton(name: "Done", onPressed: _submitForm),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of( context,).showSnackBar(const SnackBar(content: Text('Form is valid'),
       duration: Duration(seconds: 3),));
    }
  }
}
