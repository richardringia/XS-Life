import 'package:xs_life/src/features/authentication/domain/user_detail.dart';

class ForumQuestion {
  final String category;
  final String topic;
  final String question;
  final UserDetail? userDetail;

  ForumQuestion({
    required this.category,
    required this.topic,
    required this.question,
    this.userDetail,
  });
}
