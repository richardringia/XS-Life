import 'package:xs_life/src/common_widgets/repository_interface.dart';
import 'package:xs_life/src/constants/entities/Forum.dart';

abstract class IForumRepository extends IRepository {
  Future<void> addQuestion(String category, String question);
  Future<void> addCommentToQuestion(String question_key, String text);
  Future<Forum> getQuestionByKey(String key);
  Future<void> addViewToQuestion(String key);
  Future<void> likeQuestion(String question_key);
}
