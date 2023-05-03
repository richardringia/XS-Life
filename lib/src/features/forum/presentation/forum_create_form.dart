import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xs_life/src/features/forum/data/forum_category.dart';

class ForumCreateForm extends StatefulWidget {
  const ForumCreateForm({
    super.key,
    required this.addQuestion,
  });

  final FutureOr<void> Function(String category, String topic, String question)
      addQuestion;

  @override
  State<StatefulWidget> createState() => ForumCreateFormState();
}

class ForumCreateFormState extends State<ForumCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final _category = TextEditingController();
  final _topic = TextEditingController();
  final _question = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add question"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField(
                items: ForumCategory.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.name,
                        child: Text(ForumCategoryHelper.getViewName(e)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  print(value);
                },
              ),
              TextFormField(
                controller: _topic,
                decoration: const InputDecoration(
                  hintText: 'Topic',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your topic to continue';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _question,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 8,
                decoration: const InputDecoration(
                  hintText: 'Question',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your question to continue';
                  }
                  return null;
                },
              ),
              OutlinedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await widget.addQuestion(
                      _category.text,
                      _topic.text,
                      _question.text,
                    );
                  }
                  // print(_controller.text);
                },
                child: Row(
                  children: const [
                    Icon(Icons.send),
                    SizedBox(width: 4),
                    Text('SEND'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
