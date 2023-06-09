class QuestionModel {
  String id;
  final String title;
  final String createdAt;

  QuestionModel({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      title: json['title'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt,
    };
  }
}
