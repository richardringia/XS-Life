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

    return Card(
      elevation: 2, // Adjust the elevation value to control the shadow depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(forumQuestion.userDetail!.getFullName() ?? "Anonymous"),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            alignment: Alignment.topLeft,
            child: Text(forumQuestion.question),
          ),
          ButtonTheme(
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite),
                      color: forumQuestion.hasUserLiked()
                          ? Colors.pink
                          : Colors.grey,
                      onPressed: () {
                        forumRepository.likeQuestion(forumQuestion.key);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.comment_outlined),
                      onPressed: () {
                        context.push(
                            '/${PageConstants.forum}/edit/${forumQuestion.key}');
                      },
                    ),
                  ],
                ),
                Text("${forumQuestion.getTotalLikes()} likes")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
