class BadgeModel {
  final int id;
  final String name;
  final String iconUrl;
  final int requiredScore;

  BadgeModel({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.requiredScore,
  });

  factory BadgeModel.fromJson(Map<String, dynamic> json) {
    return BadgeModel(
      id: json['id'],
      name: json['name'],
      iconUrl: json['iconUrl'],
      requiredScore: json['requiredScore'],
    );
  }
}
