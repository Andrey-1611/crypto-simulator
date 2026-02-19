class AppUser {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;
  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  AppUser copyWith({
    String? id,
    String? name,
    String? email,
    DateTime? createdAt,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}