import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xs_life/src/constants/page_constants.dart';
import 'package:xs_life/src/features/forum/data/forum_repository.dart';
import 'package:xs_life/src/features/forum/domain/forum_question.dart';

class ForumQuestionCard extends StatelessWidget {
  final ForumQuestion forumQuestion;

  const ForumQuestionCard({
    Key? key,
    required this.forumQuestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ForumRepository forumRepository = ForumRepository();

    return Padding(
      padding: const EdgeInsets.all(8.0), // Adjust the value to your preference
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Adjust the value to your preference
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(
                forumQuestion.userDetail!.getFullName() ?? "Anonymous",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              alignment: Alignment.topLeft,
              child: Text(forumQuestion.question),
            ),
            ButtonTheme(
              child: ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  // Make it show the number of likes using Firebase
                  IconButton(
                    icon: const Icon(Icons.thumb_up),
                    onPressed: () {
                      forumRepository.likeQuestion(forumQuestion.key);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: () {
                      context.push('/${PageConstants.forum}/edit/${forumQuestion.key}');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
