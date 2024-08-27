class User {
  final String login;
  final String avatarUrl;
  final String reposUrl;
  final String subscriptionsUrl;
  final String name;
  final int followers;
  final int following;
  final String type;
  final String bio;
  final String email;
  User({
    required this.login,
    required this.avatarUrl,
    required this.name,
    required this.followers,
    required this.following,
    required this.type,
    required this.bio,
    required this.reposUrl,
    required this.email,
    required this.subscriptionsUrl,
  });
}