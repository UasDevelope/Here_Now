import 'package:intl/intl.dart';

class Event {
  final String id;
  final String description;
  final String image;
  final String video;
  final double latitude;
  final double longitude;
  final String location;
  final String contact;
  final int price;
  final User? user; // Nullable User object
  final DateTime startDate;
  final DateTime endDate;
  final List<dynamic> rating;
  final List<String> comments;
  final int score;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String averageRating; // New field
  final bool userRated; // New field

  Event({
    required this.id,
    required this.description,
    required this.image,
    required this.video,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.contact,
    required this.price,
    this.user, // Optional User parameter
    required this.startDate,
    required this.endDate,
    required this.rating,
    required this.comments,
    required this.score,
    required this.createdAt,
    required this.updatedAt,
    required this.averageRating,
    required this.userRated,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['_id'] ?? '',
        description: json['description'] ?? '',
        image: json['image'] ?? '',
        video: json['video'] ?? '',
        latitude: json['lat']?.toDouble() ?? 0.0,
        longitude: json['long']?.toDouble() ?? 0.0,
        location: json['location'] ?? '',
        contact: json['contact'] ?? '',
        price: json['price'] ?? 0,
        // Handle null user
        user: json['user'] != null ? User.fromJson(json['user']) : null,
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        rating: json['rating'] ?? [],
        comments:
            List<String>.from(json['comment']?.map((c) => c['_id']) ?? []),
        score: json['score'] ?? 0,
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        averageRating: json["averageRating"],
        userRated: json["userRated"]);
  }

  String getFormattedStartDate() {
    return DateFormat('yyyy-MM-dd HH:mm').format(startDate);
  }

  String getFormattedEndDate() {
    return DateFormat('yyyy-MM-dd HH:mm').format(endDate);
  }
}

class User {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? contact;
  final String? image;
  final String? email;
  final double? latitude;
  final double? longitude;
  final String? locationName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    this.firstName,
    this.lastName,
    this.contact,
    this.image,
    this.email,
    this.latitude,
    this.longitude,
    this.locationName,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      firstName: json['firstName'],
      lastName: json['lastName'],
      contact: json['contact'],
      image: json['image'],
      email: json['email'],
      latitude: json['lat']?.toDouble(),
      longitude: json['long']?.toDouble(),
      locationName: json['locationName'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}
