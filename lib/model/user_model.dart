class UserModel {
  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String? address;
  final String? profileImageUrl;

  UserModel({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.address,
    this.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    String? imageUrl;
    if (json['profileImages'] != null &&
        json['profileImages'] is List &&
        json['profileImages'].isNotEmpty) {
      imageUrl = json['profileImages'][0]['url'];
    }

    return UserModel(
      id: json['id'],
      name: json['name'] ?? 'Unknown',
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      profileImageUrl: imageUrl,
    );
  }
}
