import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:xs_life/src/constants/firebase_options.dart';
import 'package:xs_life/src/features/forum/domain/ForumQuestion.dart';

class AppState extends ChangeNotifier {
  AppState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  StreamSubscription<QuerySnapshot>? _forumQuestionsSubscription;
  List<ForumQuestion> _forumQuestions = [];
  List<ForumQuestion> get forumQuestions => _forumQuestions;


  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _forumQuestionsSubscription = FirebaseFirestore.instance
            .collection('forum')
            .orderBy('created_at', descending: true)
            .snapshots()
            .listen((snapshot) {
          _forumQuestions = [];
          for (final document in snapshot.docs) {
            _forumQuestions.add(
              ForumQuestion(
                category: document.data()['category'] as String,
                topic: document.data()['topic'] as String,
                question: document.data()['question'] as String,
              ),
            );
          }
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _forumQuestions = [];
        _forumQuestionsSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  Future<DocumentReference> addQuestionToForum(
      String category, String topic, String question) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance.collection('forum').add(<String, dynamic>{
      'category': category,
      'topic': topic,
      'question': question,
      'user_key': FirebaseAuth.instance.currentUser!.uid,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
