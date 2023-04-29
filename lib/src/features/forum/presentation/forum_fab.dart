import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xs_life/src/constants/page_constants.dart';

class ForumFab extends StatelessWidget {
  const ForumFab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: FloatingActionButton(
        heroTag: PageConstants.forum,
        onPressed: () {
          context.push('/${PageConstants.forum}');
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.groups),
      ),
    );
  }
}
