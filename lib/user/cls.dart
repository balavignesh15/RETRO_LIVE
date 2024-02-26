class getall {
  String userId;
  String name;
  String password;

  getall({
    required this.userId,
    required this.name,
    required this.password,
  });

  getall copyWith({String? name, String? password}) {
    return getall(
      userId: this.userId,
      name: name ?? this.name,
      password: password ?? this.password,
    );
  }
}