class NewsResponse {
  final String message;
  final List<NewsWithScore> newsWithScores;

  NewsResponse({
    required this.message,
    required this.newsWithScores,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      message: json['message'] ?? '',
      newsWithScores: (json['newsWithScores'] as List<dynamic>)
          .map((news) => NewsWithScore.fromJson(news))
          .toList(),
    );
  }
}

class NewsWithScore {
  final String id;
  final String title;
  final String description;
  final String? image;
  final String? video;
  final String typeNews;
  final String category;
  final double lat;
  final double long;
  final double averageRating;
  final String location;
  final String city;
  final String state;
  final String country;
  final User user;
  final int views;
  final List<dynamic> newsComments;
  final List<dynamic> rating;
  final int score;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int commentsCount;
  final bool isRating;
  NewsWithScore({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    this.video,
    required this.typeNews,
    required this.category,
    required this.lat,
    required this.long,
    required this.averageRating,
    required this.location,
    required this.city,
    required this.isRating,
    required this.state,
    required this.country,
    required this.user,
    required this.views,
    required this.newsComments,
    required this.rating,
    required this.score,
    required this.createdAt,
    required this.updatedAt,
    required this.commentsCount,
  });

  factory NewsWithScore.fromJson(Map<String, dynamic> json) {
    return NewsWithScore(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'],
      video: json['video'],
      isRating: json['isRated'] ?? false,
      typeNews: json['typeNews'] ?? '',
      category: json['category'] ?? '',
      lat: (json['lat'] ?? 0).toDouble(),
      long: (json['long'] ?? 0).toDouble(),
      averageRating: double.tryParse(json['averageRating'].toString()) ?? 0.0,
      location: json['location'] ?? '',
      city: json['city'] ?? 'Mountain View', // Default: Mountain View
      state: json['state'] ?? 'California', // Default: California
      country: json['country'] ?? 'United States', // Default: United States
      user: json['user'] != null ? User.fromJson(json['user']) : _defaultUser(),
      views: json['views'] ?? 0,
      newsComments: json['newsComments'] ?? [],
      rating: json['rating'] ?? [],
      score: json['score'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      commentsCount: json['commentsCount'] ?? 0,
    );
  }

// Helper method to return a default user if the field is null
  static User _defaultUser() {
    return User(
      id: '',
      firstName: 'Unknown',
      lastName: 'User',
      image: null,
    );
  }
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String? image;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      image: json['image'],
    );
  }
}
