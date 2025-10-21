class PostItemModel {
  String? type;
  String? title;
  String? timeLostAt;
  String? description;
  String? location;
  String? imageUrl;
  int? userId;
  int? categoryId;

  PostItemModel({
    this.type,
    this.title,
    this.timeLostAt,
    this.description,
    this.location,
    this.imageUrl,
    this.userId,
    this.categoryId,
  });

  PostItemModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    timeLostAt = json['timeLostAt'];
    description = json['description'];
    location = json['location'];
    imageUrl = json['imageUrl'];
    userId = json['userId'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['timeLostAt'] = this.timeLostAt;
    data['description'] = this.description;
    data['location'] = this.location;
    data['imageUrl'] = this.imageUrl;
    data['userId'] = this.userId;
    data['categoryId'] = this.categoryId;
    return data;
  }
}
