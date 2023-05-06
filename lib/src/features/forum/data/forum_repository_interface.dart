import 'package:xs_life/src/common_widgets/repository_interface.dart';

abstract class IForumRepository extends IRepository {
  Future<void> addQuestion(String category, String topic, String question);
  Future<void> addCommentToQuestion(String question_key, String text);
}