class Contact {
  final String name;
  final String email;
  final String phone;
  final String? imagePath;

  Contact({
    required this.name,
    required this.email,
    required this.phone,
    this.imagePath,
  });

  Contact copyWith({
    String? name,
    String? email,
    String? phone,
    String? imagePath,
  }) {
    return Contact(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'imagePath': imagePath,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      imagePath: map['imagePath'],
    );
  }
}
