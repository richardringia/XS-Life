import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xs_life/src/features/forum/data/forum_category.dart';
import 'package:xs_life/src/features/forum/data/forum_repository.dart';

class ForumCreateForm extends StatefulWidget {
  const ForumCreateForm({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => ForumCreateFormState();
}

class ForumCreateFormState extends State<ForumCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final _category = TextEditingController();
  final _question = TextEditingController();

  final ForumRepository forumRepository = ForumRepository();

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
                  _category.text = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                } ,
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
                    await forumRepository.addQuestion(
                      _category.text,
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
