class User {
  final String id;
  final String name;
  final String email;
  final String position;
  final String department;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.position,
    required this.department,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      position: json['position'] ?? '',
      department: json['department'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'position': position,
      'department': department,
    };
  }
}
