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
  ForumCategory? _category;
  bool categoryHasError = false;
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
        child: Container(
          // ignore: prefer_const_constructors
          color: Color.fromARGB(131, 169, 169, 169),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 243, 216),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        height: 80,
                        child: Row(
                          children: ForumCategory.values
                              .map(
                                (category) => Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: FilterChip(
                                    selectedColor:
                                        Color.fromARGB(255, 255, 159, 14),
                                    backgroundColor:
                                        Color.fromARGB(248, 253, 211, 121),
                                    label: Text(
                                      ForumCategoryHelper.getViewName(category),
                                    ),
                                    selected: category == _category,
                                    onSelected: (bool value) {
                                      if (value) {
                                        setState(() {
                                          _category = category;
                                        });
                                      } else {
                                        setState(() {
                                          _category = null;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),

                // Section 2
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 30, 8, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 243, 216),
                      borderRadius: BorderRadius.circular(17),
                      
                    ),
                    child: Column(
                      // lookink array from here
                      children: [
                        // section 1
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 50, 8, 0),
                          child: Container(
                            color: Color.fromARGB(255, 255, 243, 216),
                            // Textformfield
                            child: TextFormField(
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
                          ),
                        ),

                        //  end section 1
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                          child: OutlinedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (_category == null) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                            'Please select a category'),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Close'))
                                        ],
                                      ),
                                    );
                                  } else {
                                    forumRepository
                                        .addQuestion(
                                          _category!.name,
                                          _question.text,
                                        )
                                        .then(
                                            (value) => Navigator.pop(context));
                                  }
                                }
                                // print(_controller.text);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 255, 159, 14)),
                              ),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'SEND',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],

                      // the end of the section
                    ),
                  ),
                ),
                // the end of setion button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
