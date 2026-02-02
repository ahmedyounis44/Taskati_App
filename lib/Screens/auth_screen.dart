import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/screens/home_screen.dart';
import 'package:flutter_tasks_app/services/validator_service.dart';
import 'package:flutter_tasks_app/widgets/custombutton.dart';
import 'package:flutter_tasks_app/app_strings.dart';
import 'package:flutter_tasks_app/models/user_model.dart';
import 'package:hive_flutter/adapters.dart';
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
  final TextEditingController nameController = TextEditingController();
  Box<UserModel> userBox = Hive.box<UserModel>(AppStrings.userBox);
  void getImageFromCamera() async {
    photo = await picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  void getImageFromGallery() async {
    photo = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  /*@override
  void initState() {
   super.initState();
  }*/

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
            SizedBox(height: 10),
            Custombutton(
              name: "Upload From Camera",

              onPressed: getImageFromCamera,
            ),
            SizedBox(height: 20),
            Custombutton(
              name: "Upload From Gallery",

              onPressed: getImageFromGallery,
            ),

            SizedBox(height: 30),
            Divider(height: 2),
            SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onTapOutside: (value) {
                      FocusScope.of(context).unfocus();
                    },
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      hint: Text("Enter Your Name"),
                    ),
                    keyboardType: TextInputType.name,
                    validator: ValidatorService.validateName,
                  ),

                  const SizedBox(height: 20),

                  // ignore: void_checks
                  Custombutton(name: "Done", onPressed: _submitForm),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (photo == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an image'),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      /*ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form is valid'),
          duration: Duration(seconds: 3),
        ),
      );*/
      await userBox.clear();

      userBox
          .add(UserModel(name: nameController.text, image: photo?.path ?? ""))
          .then((value) {
            print("user added with id: $value");
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          })
          .catchError((error) {
            print("Failed to add user: $error");
          });
    }
  }
}
