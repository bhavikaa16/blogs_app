class User {
    final int id;
    final String firstName;
    final String lastName;
    final String email;
    final String image;

    User({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.image,
    });

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            id: json['id'] ?? 0,
            firstName: json['firstName'] ?? '',
            lastName: json['lastName'] ?? '',
            email: json['email'] ?? '',
            image: json['image'] ?? '',
        );
    }

    Map<String, dynamic> toJson() {
        return {
            'id': id,
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'image': image,
        };
    }

    String get fullName => '$firstName $lastName';
}
