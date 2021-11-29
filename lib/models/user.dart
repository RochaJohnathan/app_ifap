class User {
  final String? id;
  final String name;
  final String email;
  final String? urlAvatar;

  const User({
    this.id,
    required this.name,
    required this.email,
    this.urlAvatar,
  });
}
