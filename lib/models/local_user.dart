class LocalUser {
  final String id;
  final String? name;
  final String? photoUrl;

  LocalUser({
    required this.id,
    this.name,
    this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'photoUrl': photoUrl,
    };
  }
}
