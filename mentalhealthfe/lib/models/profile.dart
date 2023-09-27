class Profile {
  String? avatar;
  String? bio;

  Profile({
    required this.avatar,
    required this.bio,
  });

  factory Profile.fromJson(Map<String?, dynamic> json) {
    return Profile(
      avatar: json['avatar'] ?? '',
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar': avatar,
      'bio': bio,
    };
  }
}
