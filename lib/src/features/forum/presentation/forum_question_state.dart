import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xs_life/src/constants/collection_constants.dart';
import 'package:xs_life/src/features/authentication/data/auth_service.dart';
import 'package:xs_life/src/features/authentication/data/user_repository.dart';
import 'package:xs_life/src/features/authentication/domain/user_detail.dart';
import 'package:xs_life/src/features/forum/domain/forum_question.dart';
import 'package:xs_life/src/features/forum/domain/forum_question_comment.dart';

class ForumQuestionState extends ChangeNotifier {
  final String question;

  ForumQuestionState(this.question) {
    init();
  }

  final forumCollection = FirebaseFirestore.instance.collection("forum");

  UserRepository userRepository = UserRepository();

  ForumQuestion? _forumQuestion;

  ForumQuestion? get forumQuestion => _forumQuestion;

  StreamSubscription<QuerySnapshot>? _forumQuestionCommentSubscription;

  List<ForumQuestionComment>? _forumQuestionComments;

  List<ForumQuestionComment>? get forumQuestionComments =>
      _forumQuestionComments;

  Future<void> init() async {
    var questionResult = await forumCollection.doc(question).get();
    if (questionResult.exists) {
      UserDetail? userDetail = await userRepository
          .getUserDetails(questionResult.data()?['user_key']);
      if (userDetail != null) {
        _forumQuestion = ForumQuestion(
          category: questionResult.data()?['category'] as String,
          topic: questionResult.data()?['topic'] as String,
          question: questionResult.data()?['question'] as String,
          key: questionResult.id,
          userDetail: userDetail,
        );

        _forumQuestionCommentSubscription = FirebaseFirestore.instance
            .collection(CollectionConstants.forumComment)
            .where('question_key', isEqualTo: question)
            .orderBy('created_at', descending: true)
            .snapshots()
            .listen((snapshot) {
          _forumQuestionComments = [];
          for (final comment in snapshot.docs) {
            _forumQuestionComments?.add(
              ForumQuestionComment(
                comment.id,
                comment.data()['user_key'],
                comment.data()['question_key'],
                comment.data()['text'],
                DateTime.fromMillisecondsSinceEpoch(
                    comment.data()['created_at'] * 1000),
              ),
            );
          }
          notifyListeners();
        });

        notifyListeners();
      }
    }
  }
}
