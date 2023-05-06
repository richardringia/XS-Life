class ForumQuestionComment {
  final String key;
  final String user_key;
  final String question_key;
  final String text;
  final DateTime? created_at;

  ForumQuestionComment(this.key, this.user_key, this.question_key, this.text,
      this.created_at);

  Map<String, dynamic> toMap() {
    return {
      'user_key': user_key,
      'question_key': question_key,
      'text': text,
      'created_at': created_at,
    };
  }
}
