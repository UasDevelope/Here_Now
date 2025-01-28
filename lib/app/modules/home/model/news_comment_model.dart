class NewsCommentResponse {
  final String message;
  final List<NewsComment> comments;

  NewsCommentResponse({
    required this.message,
    required this.comments,
  });

  factory NewsCommentResponse.fromJson(Map<String, dynamic> json) {
    return NewsCommentResponse(
      message: json['message'] ?? '',
      comments: (json['comments'] as List<dynamic>)
          .map((comment) => NewsComment.fromJson(comment))
          .toList(),
    );
  }
}

class NewsComment {
  final String id;
  final User user;
  final String newsId;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  NewsComment({
    required this.id,
    required this.user,
    required this.newsId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory NewsComment.fromJson(Map<String, dynamic> json) {
    return NewsComment(
      id: json['_id'] ?? '',
      user: User.fromJson(json['user']),
      newsId: json['newsId'] ?? '',
      content: json['content'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'] ?? 0,
    );
  }
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String? image;
  final String email;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.image,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      image: json['image'],
      email: json['email'] ?? '',
    );
  }
}
