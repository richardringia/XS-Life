import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xs_life/src/constants/page_constants.dart';

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
          heroTag: PageConstants.profile,
          onPressed: () {
            context.push('/${PageConstants.profile}');
          },
          backgroundColor: Colors.orange,
          child: const Icon(Icons.person),
        ),
      ),
    );
  }
}
