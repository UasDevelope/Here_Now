class UserResponse {
  final bool success;
  final String message;
  final UserModel data;

  UserResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: UserModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String? contact;
  final String? image;
  final String email;
  final String password;
  final double lat;
  final double long;
  final String locationName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.contact,
    this.image,
    required this.email,
    required this.password,
    required this.lat,
    required this.long,
    required this.locationName,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      contact: json['contact'] as String?,
      image: json['image'] as String?,
      email: json['email'] as String,
      password: json['password'] as String,
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(),
      locationName: json['locationName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: json['__v'] as int,
    );
  }
}
