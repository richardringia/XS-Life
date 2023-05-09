import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xs_life/src/constants/collection_constants.dart';
import 'package:xs_life/src/features/forum/data/forum_repository_interface.dart';

class ForumRepository extends IForumRepository {
  @override
  Future<void> addCommentToQuestion(String question_key, String text) async {
    await checkAuth();

    FirebaseFirestore.instance
        .collection(CollectionConstants.forumComment)
        .add({
      'question_key': question_key,
      'text': text,
      'votes': 0,
      'user_key': FirebaseAuth.instance.currentUser!.uid,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  Future<void> addQuestion(
      String category, String topic, String question) async {
    await checkAuth();

    FirebaseFirestore.instance
        .collection(CollectionConstants.forum)
        .add(<String, dynamic>{
      'category': category,
      'topic': topic,
      'question': question,
      'user_key': FirebaseAuth.instance.currentUser!.uid,
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'views': 0
    });
  }

  
}
