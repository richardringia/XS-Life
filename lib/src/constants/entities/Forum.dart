class Forum {
  late int views;
  late String category;
  late String question;
  late String topic;
  late String user_key;
  late int created_at;

  Forum({
    required this.views,
    required this.category,
    required this.question,
    required this.topic,
    required this.user_key,
    required this.created_at,
  });

  static fromMap(Map<String, dynamic> data) {
    return Forum(
      views: data['views'],
      category: data['category'],
      question: data['question'],
      topic: data['topic'],
      user_key: data['user_key'],
      created_at: data['created_at'],
    );
  }
}
