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
        actions: [
          Image.asset(
            'assets/images/Artboard_11.png',
            height: 120,
            width: 120,
          ),
        ],
        toolbarHeight: 100,
        // ignore: prefer_const_constructors
        backgroundColor: Color.fromARGB(255, 255, 110, 14),
        flexibleSpace: Container(
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // ignore: prefer_const_constructors
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // ignore: prefer_const_literals_to_create_immutables
                  colors: [
                    // ignore: prefer_const_constructors
                    Color.fromARGB(255, 255, 110, 14),
                    // ignore: prefer_const_constructors
                    Color.fromARGB(255, 252, 213, 134)
                  ])),
        ),
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
                    forumRepository.addQuestion(
                      _category.text,
                      _question.text,
                    ).then((value) => Navigator.pop(context));
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
