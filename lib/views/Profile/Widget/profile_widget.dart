

import 'package:flutter/material.dart';
import 'package:med_care/Services/api_services.dart';
import 'package:med_care/controller/profile_controller.dart';
import 'package:med_care/views/Login/login_view.dart';
import 'package:med_care/views/Profile/Widget/profile_textfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  @override
@override
void initState() {
  super.initState();

  Future.microtask(() {
    if (mounted) {
      Provider.of<ProfileController>(
        context,
        listen: false,
      ).loadUserProfile();
    }
  });
}


  @override
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    final profileProvider = Provider.of<ProfileController>(context);

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
              onPressed: () async {
                final result =
                    await ApiServices.logout(); // call the logout API

                if (result != null && result.statusCode == 200) {
                  // Clear shared preferences
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();

                  // Navigate to login screen and remove all previous routes
                  if(context.mounted){
                   Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false,
                  );
                  }
                  
                } else {

                if(context.mounted){
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Logout failed. Please try again.'),
                    ),
                  );
                }
                }
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
                "Your Profile",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
              child: Form(
                child: Column(
                  children: [
                    textfieldprofile(
                      controller: TextEditingController(
                        text: profileProvider.userName,
                      ),

                      icon: Icons.person,
                      label: "Full Name",
                      width: screenWidth,
                      readOnly: true,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    textfieldprofile(
                      controller: TextEditingController(
                        text: profileProvider.email,
                      ),
                      icon: Icons.email,
                      label: "Email",
                      width: screenWidth,
                      readOnly: true,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    textfieldprofile(
                      controller: TextEditingController(
                        text: profileProvider.phone,
                      ),
                      icon: Icons.phone,
                      label: "Phone number",
                      width: screenWidth,
                      inputType: TextInputType.number,
                      readOnly: true,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    textfieldprofile(
                      controller: TextEditingController(
                        text: profileProvider.place,
                      ),
                      icon: Icons.place,
                      label: "Place",
                      width: screenWidth,
                      readOnly: true,
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
