import 'package:flutter/material.dart';
import 'package:xs_life/src/features/app/presentation/fab_navigation_widget.dart';
import 'package:xs_life/src/features/forum/domain/forum_question.dart';
import 'package:xs_life/src/features/forum/presentation/forum_question_card.dart';

class ForumScreenWidget extends StatefulWidget {
  const ForumScreenWidget({super.key, required this.questions});

  final List<ForumQuestion> questions;

  @override
  State<ForumScreenWidget> createState() => _ForumScreenWidgetState();
}

class _ForumScreenWidgetState extends State<ForumScreenWidget> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forum"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.fromLTRB(0, 7, 0, 7),
              child: ForumQuestionCard(
                forumQuestion: widget.questions[index],
              ),
            );
          },
          itemCount: widget.questions.length,
        ),
        // Column(
        //   children: [
        //     // for (var message in widget.questions)
        //     //   const BasicCard(),
        //     // ListTile(
        //     //   title: Text(message.topic),
        //     //   subtitle: Text(message.question),
        //     // ),
        //     Visibility(
        //       visible: AuthService.loggedIn(),
        //       child: OutlinedButton(
        //         onPressed: () {
        //           context.push('/${PageConstants.forum}/add');
        //         },
        //         child: const Text('Add post'),
        //       ),
        //     ),
        //   ],
        // ),
      ),
      floatingActionButton: const FabNavigationWidget(),
    );
  }
}
