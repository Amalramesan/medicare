import 'package:flutter/material.dart';
import 'package:med_care/View_model/controller/logout_controller.dart';
import 'package:med_care/View_model/controller/profile_controller.dart';
import 'package:med_care/data/response/status.dart';
import 'package:med_care/views/Profile/Widget/profile_textfield.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
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
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    final profileProvider = Provider.of<ProfileController>(context);
    final profileState = profileProvider.profileResponse;

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
                final logoutController = Provider.of<LogoutController>(
                  context,
                  listen: false,
                );

                // Show loading dialog
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );

                await logoutController.logout(context);

                if (context.mounted) {
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
            ),
          ),
        ],
      ),
      body: Builder(
        builder: (_) {
          if (profileState.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (profileState.status == Status.error) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Failed to load profile: ${profileState.message}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          final profile = profileState.data?.data;

          return SingleChildScrollView(
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
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.045,
                  ),
                  child: Form(
                    child: Column(
                      children: [
                        textfieldprofile(
                          controller: TextEditingController(
                            text: profile?.name ?? '',
                          ),
                          icon: Icons.person,
                          label: "Full Name",
                          width: screenWidth,
                          readOnly: true,
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        textfieldprofile(
                          controller: TextEditingController(
                            text: profile?.email ?? '',
                          ),
                          icon: Icons.email,
                          label: "Email",
                          width: screenWidth,
                          readOnly: true,
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        textfieldprofile(
                          controller: TextEditingController(
                            text: profile?.phoneNumber ?? '',
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
                            text: profile?.place ?? '',
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
          );
        },
      ),
    );
  }
}
