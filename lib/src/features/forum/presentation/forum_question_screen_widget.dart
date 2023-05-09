import 'package:flutter/material.dart';
import 'package:xs_life/src/common_widgets/loading_screen_widget.dart';
import 'package:xs_life/src/features/forum/data/forum_repository.dart';
import 'package:xs_life/src/features/forum/domain/forum_question.dart';
import 'package:xs_life/src/features/forum/domain/forum_question_comment.dart';

class ForumQuestionScreenWidget extends StatefulWidget {
  const ForumQuestionScreenWidget(
      {Key? key, this.forumQuestion, this.forumQuestionComments})
      : super(key: key);

  final ForumQuestion? forumQuestion;
  final List<ForumQuestionComment>? forumQuestionComments;

  @override
  State<StatefulWidget> createState() => ForumQuestionScreenWidgetState();
}

class ForumQuestionScreenWidgetState extends State<ForumQuestionScreenWidget> {
  final _formKey = GlobalKey<FormState>();
  final _comment = TextEditingController();
  ForumRepository forumRepository = ForumRepository();
  // FirebaseFirestore.instance.collection(CollectionConstants.forumComment)
  @override
  Widget build(BuildContext context) {
    var details = Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.forumQuestion?.topic ?? ""),
          Text(widget.forumQuestion?.question ?? ""),
        ],
      ),
    );
    var interactions = Container(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: const [Icon(Icons.thumb_up), Text("999 likes")],
          ),
          Column(
            children: const [Icon(Icons.comment), Text("350 comments")],
          ),
          Column(
            children: const [Icon(Icons.remove_red_eye_sharp), Text("100 see")],
          )
        ],
      ),
    );
    List<ForumQuestionComment> comments = widget.forumQuestionComments ?? [];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forum"),
      ),
      body: widget.forumQuestion == null
          ? const LoadingScreenWidget()
          : Container(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(
                          widget.forumQuestion!.userDetail!.getFullName() ??
                              "Anonymous"),
                    ),
                    details,
                    interactions,
                    Container(
                      child: Card(
                        child: Column(
                          children: [
                            Container(
                              child: const Text("----Comment section----"),
                            ),
                            Column(
                              children: [
                                for (ForumQuestionComment comment in comments)
                                  ListTile(
                                    subtitle:
                                        Text(comment.user_key ?? "Anonymous"),
                                    title: Text(comment.text),
                                  )
                              ],
                            ),
                            Form(
                              key: _formKey,
                              child: TextFormField(
                                controller: _comment,
                                decoration: const InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.send),
                                    onPressed: null,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter text to continue';
                                  }
                                  return null;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
