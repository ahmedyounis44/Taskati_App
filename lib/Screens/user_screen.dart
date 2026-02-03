import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/app_strings.dart';
import 'package:flutter_tasks_app/models/user_model.dart';
import 'package:flutter_tasks_app/screens/home_screen.dart';
import 'package:flutter_tasks_app/services/validator_service.dart';
import 'package:flutter_tasks_app/widgets/custombutton.dart';
import 'package:hive/hive.dart' show Hive;
import 'package:image_picker/image_picker.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserModel? currentUser;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  XFile? photo;
  void getImageFromCamera() async {
    photo = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      currentUser?.image = photo?.path ?? "";
      Hive.box<UserModel>(AppStrings.userBox).putAt(0, currentUser!);
    });
  }

  void getImageFromGallery() async {
    photo = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      currentUser?.image = photo?.path ?? "";
      Hive.box<UserModel>(AppStrings.userBox).putAt(0, currentUser!);
    });
  }

  @override
  Widget build(BuildContext context) {
    currentUser = Hive.box<UserModel>(AppStrings.userBox).getAt(0);
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: Color(0xFF5B6CFF),
        title: const Text(
          'User Profile',
          style: TextStyle(color: Colors.white),
        ),
        leading:  BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.of(
              context,
            ).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),

          /// Profile Image
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: Image.file(
                  File(photo?.path ?? currentUser?.image ?? ""),
                ).image,
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFF5B6CFF),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.camera_alt,
                    size: 16,
                    color: Colors.white,
                  ),
                  onPressed: () => _showUploadSheet(context),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          Divider(color: Color(0xFF5B6CFF).withAlpha(60)),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currentUser?.name ?? "",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5B6CFF),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Color(0xFF5B6CFF)),
                  onPressed: () => _showNameSheet(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showUploadSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Custombutton(
                name: "Upload From Camera",

                onPressed: getImageFromCamera,
              ),
              SizedBox(height: 20),
              Custombutton(
                name: "Upload From Gallery",

                onPressed: getImageFromGallery,
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showNameSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                    Custombutton(
                      name: "Update Your Name",
                      onPressed: _submitForm,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        currentUser?.name = nameController.text;
        Hive.box<UserModel>(AppStrings.userBox).putAt(0, currentUser!);
      });
    }
  }
}
