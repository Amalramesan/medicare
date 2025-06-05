import 'dart:io';

import 'package:flutter/material.dart';
import 'package:med_care/views/Login/login_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_care/views/Profile/Widget/profile_textfield.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  File? _imageFile;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Text(
            "Profile",
            style: TextStyle(
              fontSize: screenWidth * 0.065,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.03),
            child: IconButton(
              icon: const Icon(Icons.logout, size: 27, color: Colors.red),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.045),
              child: Text(
                "Edit your profile",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.15,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : null,
                      child: _imageFile == null
                          ? Icon(Icons.person, size: screenWidth * 0.12)
                          : null,
                    ),
                    Positioned(
                      right: 5,
                      bottom: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: screenWidth * 0.055,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: screenWidth * 0.045,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
              child: Form(
                child: Column(
                  children: [
                    Textfieldprofile(
                      controller: nameController,
                      icon: Icons.person,
                      label: "Full Name",
                      width: screenWidth,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Textfieldprofile(
                      controller: emailController,
                      icon: Icons.email,
                      label: "Email",
                      width: screenWidth,
                      readOnly: true,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Textfieldprofile(
                      controller: phoneController,
                      icon: Icons.phone,
                      label: "Phone number",
                      width: screenWidth,
                      inputType: TextInputType.number,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Textfieldprofile(
                      controller: placeController,
                      icon: Icons.place,
                      label: "Place",
                      width: screenWidth,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.065,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Update",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.045,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
