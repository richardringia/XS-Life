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
      appBar: AppBar(
        actions: [
          Image.asset(
            'assets/images/Artboard_11.png',
            height: 120,
            width: 120,
          ),
        ],
        toolbarHeight: 100,
        backgroundColor: const Color.fromARGB(255, 255, 110, 14),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // ignore: prefer_const_literals_to_create_immutables
                  colors: [
                Color.fromARGB(255, 255, 110, 14),
                Color.fromARGB(255, 252, 213, 134)
              ])),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _firstName,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  hintText: 'Enter your first name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                  controller: _lastName,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    hintText: 'Enter your last name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  }),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        UserRepository userRepo = UserRepository();
                        UserDetail? userDetail = widget.userDetail;
                        if (userDetail != null) {
                          userDetail.firstname = _firstName.text;
                          userDetail.lastname = _lastName.text;
                          userRepo.updateUser(userDetail);
                        } else {
                          userRepo.checkLoggedInUser(
                              _firstName.text, _lastName.text);
                        }

                        const snackBar =
                            SnackBar(content: Text('User details saved'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: const Text('Save'),
                  ),
                  FilledButton(
                    onPressed: () async {
                      FirebaseAuth.instance
                          .signOut()
                          .then((value) => Navigator.pop(context));
                    },
                    child: const Text('Sign out'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
