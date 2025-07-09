import 'package:flutter/material.dart';
import 'package:med_care/Data/response/status.dart';
import 'package:med_care/view_model/controller/profile_controller.dart';
import 'package:med_care/view_model/services/store_auth_details.dart';
import 'package:med_care/views/Profile/Widget/profile_textfield.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatelessWidget {   // A stateless widget that displays a user profile screen
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    return Scaffold(  // AppBar with title and logout button
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
        actions: [         // Logout button on top right corner
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.03),
            child: IconButton(
              icon: const Icon(Icons.logout, size: 27, color: Colors.red),
              onPressed: () async {
                // Initialize storage and clear tokens
                final storage = LocalStorageService();
                await storage.init();
                await storage.clearTokens();

                // Navigate to login screen and remove all previous routes
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (_) => false,
                  );
                }
              },
            ),
          ),
        ],
      ),  
      body: SingleChildScrollView(     // Body with scrollable profile form
        child: Consumer<ProfileController>(
          builder: (context, controller, child) {
            switch (controller.profileResponse.status!) {
              case Status.loading:     // Show loading spinner while fetching profile data
                return Center(child: CircularProgressIndicator());
              case Status.completed:
                final data = controller.profileResponse.data?.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(       // Profile form with read-only fields
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.045,
                      ),
                      child: Form(
                        child: Column(
                          children: [
                            textfieldprofile(
                              controller: TextEditingController(
                                text: data?.name ?? "",
                              ),
                              icon: Icons.person,
                              label: "Full Name",
                              width: screenWidth,
                              readOnly: true,
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            textfieldprofile(
                              controller: TextEditingController(
                                text: data?.email ?? "",
                              ),
                              icon: Icons.email,
                              label: "Email",
                              width: screenWidth,
                              readOnly: true,
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            textfieldprofile(
                              controller: TextEditingController(
                                text: data?.phoneNumber ?? "",
                              ),
                              icon: Icons.phone,
                              label: "Phone Number",
                              width: screenWidth,
                              inputType: TextInputType.number,
                              readOnly: true,
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            textfieldprofile(
                              controller: TextEditingController(
                                text: data?.place ?? "",
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
                );
              case Status.error:
                return Center(child: Text(controller.error));
            }
          },
        ),
      ),
    );
  }
}
