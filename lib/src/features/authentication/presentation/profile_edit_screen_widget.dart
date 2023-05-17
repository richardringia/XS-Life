import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xs_life/src/common_widgets/loading_screen_widget.dart';
import 'package:xs_life/src/features/authentication/data/user_repository.dart';
import 'package:xs_life/src/features/authentication/domain/user_detail.dart';

class ProfileEditScreenWidget extends StatefulWidget {
  const ProfileEditScreenWidget(
      {super.key, this.userDetail, required this.isLoading});

  final UserDetail? userDetail;
  final bool isLoading;

  @override
  State<ProfileEditScreenWidget> createState() =>
      _ProfileEditScreenWidgetState();
}

class _ProfileEditScreenWidgetState extends State<ProfileEditScreenWidget> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const Scaffold(body: LoadingScreenWidget());
    }

    if (widget.userDetail != null) {
      if (_firstName.text.isEmpty) {
        _firstName.text = widget.userDetail!.firstname;
      }
      if (_lastName.text.isEmpty) {
        _lastName.text = widget.userDetail!.lastname;
      }
    }

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 147, 64),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Container(
                width: 500,
                height: 700,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(195, 255, 255, 255),
                  borderRadius:
                      BorderRadius.circular(15), // Adjust the radius as needed
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(
                          0.5), // Adjust the shadow color as needed
                      spreadRadius: 5, // Adjust the spread radius as needed
                      blurRadius: 7, // Adjust the blur radius as needed
                      offset:
                          Offset(0, 3), // Adjust the offset values as needed
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Image.asset(
                        'assets/images/Artboard_11.png', // Replace with the actual path or asset name of your image
                        width: 300, // Adjust the width as needed
                        height: 300, // Adjust the height as needed
                      ),
                    ),
                    const Text(
                      "Edit your profile",
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight:
                            FontWeight.bold, // Set the desired font weight
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Start from here
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust the radius as needed
                                  border: Border.all(
                                    color: Colors
                                        .grey, // Adjust the border color as needed
                                    width:
                                        1.0, // Adjust the border width as needed
                                  ),
                                ),
                                child: TextFormField(
                                  controller: _firstName,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(15),
                                      hintText: 'Enter your first name',
                                      border: InputBorder.none),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your first name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            // End of section 1
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust the radius as needed
                                  border: Border.all(
                                    color: Colors
                                        .grey, // Adjust the border color as needed
                                    width:
                                        1.0, // Adjust the border width as needed
                                  ),
                                ),
                                child: TextFormField(
                                    controller: _lastName,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(15),
                                        hintText: 'Enter your last name',
                                        border: InputBorder.none),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your last name';
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    width: 300,
                                    child: FilledButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          UserRepository userRepo =
                                              UserRepository();
                                          UserDetail? userDetail =
                                              widget.userDetail;
                                          if (userDetail != null) {
                                            userDetail.firstname =
                                                _firstName.text;
                                            userDetail.lastname =
                                                _lastName.text;
                                            userRepo.updateUser(userDetail);
                                          } else {
                                            userRepo.checkLoggedInUser(
                                                _firstName.text,
                                                _lastName.text);
                                          }

                                          const snackBar = SnackBar(
                                              content:
                                                  Text('User details saved'));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      },
                                      child: const Text('Save'),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        300, // Specify the desired width here
                                    child: FilledButton(
                                      onPressed: () async {
                                        FirebaseAuth.instance.signOut().then(
                                            (value) => Navigator.pop(context));
                                      },
                                      child: const Text('Sign out'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
