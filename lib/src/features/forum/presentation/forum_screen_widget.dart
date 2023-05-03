import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xs_life/src/constants/page_constants.dart';
import 'package:xs_life/src/features/app/presentation/fab_navigation_widget.dart';
import 'package:xs_life/src/features/forum/domain/ForumQuestion.dart';

class ForumScreenWidget extends StatefulWidget {
  const ForumScreenWidget({super.key, required this.questions});

  final List<ForumQuestion> questions;

  @override
  State<ForumScreenWidget> createState() => _ForumScreenWidgetState();
}

class _ForumScreenWidgetState extends State<ForumScreenWidget> {
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
            for (var message in widget.questions)
              ListTile(
                title: Text(message.topic),
                subtitle: Text(message.question),
              ),
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
