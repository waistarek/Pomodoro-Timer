class UserProfile {
  const UserProfile({
    required this.id,
    required this.email,
    required this.createdAt,
    required this.isEmailVerified,
  });

  final int id;
  final String email;
  final DateTime createdAt;
  final bool isEmailVerified;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json['id'],
        email: json['email'],
        createdAt:
            DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
        isEmailVerified: json['is_email_verified'] ?? false,
      );
}