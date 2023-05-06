import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xs_life/src/features/authentication/data/user_repository.dart';
import 'package:xs_life/src/features/authentication/domain/user_detail.dart';
import 'package:xs_life/src/features/forum/domain/forum_question.dart';

class ForumQuestionState extends ChangeNotifier {
  final String question;

  ForumQuestionState(this.question) {
    init();
  }

  final forumCollection = FirebaseFirestore.instance.collection("forum");

  UserRepository userRepository = UserRepository();

  ForumQuestion? _forumQuestion;
  ForumQuestion? get forumQuestion => _forumQuestion;

  Future<void> init() async {
    var questionResult = await forumCollection.doc(question).get();
    if (questionResult.exists) {
      UserDetail? userDetail = await userRepository
          .getUserDetails(questionResult.data()?['user_key']);
      if (userDetail != null) {
        _forumQuestion = ForumQuestion(
          key: questionResult.id,
          category: questionResult.data()?['category'] as String,
          topic: questionResult.data()?['topic'] as String,
          question: questionResult.data()?['question'] as String,
          userDetail: userDetail,
        );
        notifyListeners();
      }
    }
  }
}
