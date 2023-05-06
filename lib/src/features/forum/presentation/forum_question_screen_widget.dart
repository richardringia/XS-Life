import 'package:flutter/material.dart';
import 'package:xs_life/src/common_widgets/loading_screen_widget.dart';
import 'package:xs_life/src/features/forum/domain/forum_question.dart';

class ForumQuestionScreenWidget extends StatefulWidget {
  const ForumQuestionScreenWidget({super.key, this.forumQuestion});

  final ForumQuestion? forumQuestion;

  @override
  State<StatefulWidget> createState() => ForumQuestionScreenWidgetState();
}

class ForumQuestionScreenWidgetState extends State<ForumQuestionScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forum"),
      ),
      body: widget.forumQuestion == null
          ? const LoadingScreenWidget()
          : Text(widget.forumQuestion!.topic),
    );
  }
}
