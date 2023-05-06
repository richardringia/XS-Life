import 'package:xs_life/src/features/authentication/domain/user_detail.dart';

class ForumQuestion {
  final String key;
  final String category;
  final String topic;
  final String question;
  final UserDetail? userDetail;

  ForumQuestion({
    required this.key,
    required this.category,
    required this.topic,
    required this.question,
    this.userDetail,
  });
}
