// class UserModel {
//   final int id;
//   final String name;
//   final String? email;
//   final String? phone;
//   final String? address;
//   final String? profileImageUrl;
//   final int requiredScore;

//   UserModel({
//     required this.id,
//     required this.name,
//     this.email,
//     this.phone,
//     this.address,
//     this.profileImageUrl,
//     this.requiredScore = 0,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     String? imageUrl;
//     if (json['profileImages'] != null &&
//         json['profileImages'] is List &&
//         json['profileImages'].isNotEmpty) {
//       imageUrl = json['profileImages'][0]['url'];
//     }

//     return UserModel(
//       id: json['id'],
//       name: json['name'] ?? 'Unknown',
//       email: json['email'],
//       phone: json['phone'],
//       address: json['address'],
//       profileImageUrl: imageUrl,
//       requiredScore: json['requiredScore'] ?? 0,
//     );
//   }
// }

class UserModel {
  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String? address;
  final String? profileImageUrl;
  final int? totalScore;

  UserModel({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.address,
    this.profileImageUrl,
    this.totalScore,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Handle profileImages array safely
    String? imageUrl;
    if (json['profileImages'] != null &&
        json['profileImages'] is List &&
        json['profileImages'].isNotEmpty) {
      imageUrl = json['profileImages'][0]['url']; // adjust key if different
    }

    return UserModel(
      id: json['id'],
      name: json['name'] ?? 'Unknown',
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      profileImageUrl: imageUrl,
      totalScore: json['totalScore'],
    );
  }
}
