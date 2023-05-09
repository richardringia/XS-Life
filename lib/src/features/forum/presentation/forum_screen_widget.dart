// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xs_life/src/common_widgets/loading_screen_widget.dart';
import 'package:xs_life/src/constants/page_constants.dart';
import 'package:xs_life/src/features/app/presentation/fab_navigation_widget.dart';
import 'package:xs_life/src/features/authentication/data/auth_service.dart';
import 'package:xs_life/src/features/forum/data/forum_category.dart';
import 'package:xs_life/src/features/forum/domain/forum_question.dart';
import 'package:xs_life/src/features/forum/presentation/forum_question_card.dart';

class ForumScreenWidget extends StatefulWidget {
  const ForumScreenWidget(
      {super.key, required this.questions, required this.isLoading});

  final List<ForumQuestion> questions;
  final bool isLoading;

  @override
  State<ForumScreenWidget> createState() => _ForumScreenWidgetState();
}

class _ForumScreenWidgetState extends State<ForumScreenWidget> {
  ScrollController _scrollController = ScrollController();
  List<ForumCategory> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    List<ForumQuestion> questions = widget.questions;
    if (selectedCategories.isNotEmpty) {
      questions = questions
          .where(
            (question) =>
                selectedCategories.isEmpty ||
                selectedCategories.contains(
                  ForumCategoryHelper.getEnum(question.category),
                ),
          )
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Image.asset(
            'assets/images/Artboard_11.png',
            height: 120,
            width: 120,
          ),
          Visibility(
            visible: AuthService.loggedIn(),
            child: IconButton(
              icon: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              onPressed: () {
                context.push('/${PageConstants.forum}/add');
              },
            ),
          ),
        ],
        toolbarHeight: 100,
        backgroundColor: Color.fromARGB(255, 255, 110, 14),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // ignore: prefer_const_literals_to_create_immutables
                  colors: [
                Color.fromARGB(255, 255, 110, 14),
                Color.fromARGB(255, 252, 213, 134)
              ])),
        ),
      ),
      body: widget.isLoading
          ? const LoadingScreenWidget()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      child: Row(
                        children: ForumCategory.values
                            .map(
                              (category) => Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: FilterChip(
                                  label: Text(
                                    ForumCategoryHelper.getViewName(category),
                                  ),
                                  selected:
                                      selectedCategories.contains(category),
                                  onSelected: (bool value) {
                                    if (value) {
                                      selectedCategories.add(category);
                                    } else {
                                      selectedCategories.remove(category);
                                    }
                                    setState(() {});
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                          child: ForumQuestionCard(
                            forumQuestion: questions[index],
                          ),
                        );
                      },
                      itemCount: questions.length,
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: const FabNavigationWidget(),
    );
  }
}
