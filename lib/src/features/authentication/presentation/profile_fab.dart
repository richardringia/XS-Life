import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileFab extends StatelessWidget {
  const ProfileFab({
    super.key,
    required this.loggedIn,
  });

  final bool loggedIn;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loggedIn,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: FloatingActionButton(
          heroTag: "profile",
          onPressed: () {
            context.push('/profile');
          },
          backgroundColor: Colors.orange,
          child: const Icon(Icons.person),
        ),
      ),
    );
  }
}
