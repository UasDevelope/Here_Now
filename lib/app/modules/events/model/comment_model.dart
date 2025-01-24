class commentUser {
  final String? id;
  final String? image;
  final String email;
  final String? firstName;
  final String? lastName;
  commentUser({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
    required this.email,
  });

  factory commentUser.fromJson(Map<String, dynamic> json) {
    return commentUser(
      id: json['_id'] ?? '',
      image: json['image'],
      email: json['email'] ?? '',
      firstName: json["firstName"] ?? '',
      lastName: json["lastName"] ?? '',
    );
  }
}

class Comment {
  final String? id;
  final commentUser? user;
  final String? eventId;
  final String? content;
  final String? createdAt;
  final String? updatedAt;

  Comment({
    this.id,
    this.user,
    this.eventId,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'] ?? null,
      user: json['user'] != null
          ? commentUser.fromJson(json['user'])
          : null, // Handle null user
      eventId: json['eventId'] ?? null,
      content: json['content'] ?? null,
      createdAt: json['createdAt'] ?? null,
      updatedAt: json['updatedAt'] ?? null,
    );
  }
}
