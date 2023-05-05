import 'package:flutter/material.dart';
import 'package:xs_life/src/features/forum/domain/forum_question.dart';

class ForumQuestionCard extends StatelessWidget {
  final ForumQuestion forumQuestion;

  const ForumQuestionCard({super.key, required this.forumQuestion});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(forumQuestion.userDetail!.getFullName() ?? "Anonymous"),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            alignment: Alignment.topLeft,
            child: Text(forumQuestion.question),
          )
        ],
      ),
    );
  }
}
