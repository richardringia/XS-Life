import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xs_life/src/common_widgets/navigation_fab.dart';
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
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
            visible: !loggedIn,
            child: NavigationFab(
              location: PageConstants.signIn,
              icon: const Icon(Icons.key),
              onPressed: () {
                !loggedIn
                    ? context.push('/${PageConstants.signIn}')
                    : signOut();
              },
            )),
      ),
    );
  }
}
