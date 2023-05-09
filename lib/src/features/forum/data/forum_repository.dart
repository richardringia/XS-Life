import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xs_life/src/constants/collection_constants.dart';
import 'package:xs_life/src/constants/entities/Forum.dart';
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
  Future<void> addQuestion(String category, String question) async {
    await checkAuth();

    await FirebaseFirestore.instance
        .collection(CollectionConstants.forum)
        .add(<String, dynamic>{
      'category': category,
      'question': question,
      'user_key': FirebaseAuth.instance.currentUser!.uid,
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'views': 0
    });
  }

  @override
  Future<Forum> getQuestionByKey(String key) {
    return FirebaseFirestore.instance
        .collection("forum")
        .doc(key)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
      } else {
        print('Document does not exist on the database');
      }

      print(documentSnapshot.data());

      return Forum.fromMap(documentSnapshot.data() as dynamic);
    });
    // .then(
    //       (value) => Forum(
    //         views: value.get('views'),
    //         category: value.get('category'),
    //         question: value.get('question'),
    //         topic: value.get('topic'),
    //         user_key: value.get('user_key'),
    //         created_at: value.get('created_at'),
    //       ),
    //     );
  }

  @override
  Future<void> addViewToQuestion(String key) {
    return FirebaseFirestore.instance
        .collection('forum')
        .doc(key)
        .update({"views": FieldValue.increment(1)});
  }
}
