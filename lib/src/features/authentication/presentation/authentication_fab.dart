import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xs_life/src/constants/page_constants.dart';

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
          heroTag: PageConstants.signIn,
          onPressed: () {
            !loggedIn ? context.push('/${PageConstants.signIn}') : signOut();
          },
          backgroundColor: Colors.orange,
          child: const Icon(Icons.key),
        ),
      ),
    );
  }
}
