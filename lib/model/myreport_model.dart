class Data {
  int? id;
  String? type;
  String? title;
  String? description;
  String? location;
  Null? province;
  String? contactnumber;
  Null? district;
  String? status;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? timeLostAt;
  int? confirmedByPosterId;
  int? confirmedByClaimerId;
  Null? rewardBadge;
  Category? category;

  Data({
    this.id,
    this.type,
    this.title,
    this.description,
    this.location,
    this.province,
    this.contactnumber,
    this.district,
    this.status,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.timeLostAt,
    this.confirmedByPosterId,
    this.confirmedByClaimerId,
    this.rewardBadge,
    this.category,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    location = json['location'];
    province = json['province'];
    contactnumber = json['contactnumber'];
    district = json['district'];
    status = json['status'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    timeLostAt = json['timeLostAt'];
    confirmedByPosterId = json['confirmedByPosterId'];
    confirmedByClaimerId = json['confirmedByClaimerId'];
    rewardBadge = json['rewardBadge'];
    category =
        json['category'] != null
            ? new Category.fromJson(json['category'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['title'] = this.title;
    data['description'] = this.description;
    data['location'] = this.location;
    data['province'] = this.province;
    data['contactnumber'] = this.contactnumber;
    data['district'] = this.district;
    data['status'] = this.status;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['timeLostAt'] = this.timeLostAt;
    data['confirmedByPosterId'] = this.confirmedByPosterId;
    data['confirmedByClaimerId'] = this.confirmedByClaimerId;
    data['rewardBadge'] = this.rewardBadge;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }

    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
