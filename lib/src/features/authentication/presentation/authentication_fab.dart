import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthenticationFab extends StatelessWidget {
  const AuthenticationFab({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !loggedIn,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: FloatingActionButton(
          heroTag: "auth",
          onPressed: () {
            !loggedIn ? context.push('/sign-in') : signOut();
          },
          backgroundColor: Colors.orange,
          child: const Icon(Icons.key),
        ),
      ),
    );
  }
}
