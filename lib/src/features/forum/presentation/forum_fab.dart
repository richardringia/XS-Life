import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xs_life/src/common_widgets/navigation_fab.dart';
import 'package:xs_life/src/constants/page_constants.dart';

class ForumFab extends StatelessWidget {
  const ForumFab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const NavigationFab(
      location: PageConstants.forum,
      icon: Icon(Icons.groups),
    );
  }
}
