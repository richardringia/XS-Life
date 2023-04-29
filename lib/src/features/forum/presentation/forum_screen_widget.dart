import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xs_life/src/constants/page_constants.dart';
import 'package:xs_life/src/features/app/presentation/fab_navigation_widget.dart';

class ForumScreenWidget extends StatelessWidget {
  const ForumScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forum"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            OutlinedButton(
              onPressed: () {
                context.push('/${PageConstants.forum}/add');
              },
              child: const Text('Add post'),
            )
          ],
        ),
      ),
      floatingActionButton: const FabNavigationWidget(),
    );
  }
}
