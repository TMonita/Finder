class AllItemsModel {
  String? type;
  String? title;
  String? timeLostAt;
  String? description;
  String? location;
  String? imageUrl;
  int? userId;
  String? status;
  int? categoryId;
  String? categoryName;

  AllItemsModel({
    this.type,
    this.title,
    this.timeLostAt,
    this.description,
    this.location,
    this.imageUrl,
    this.userId,
    this.status,
    this.categoryId,
    this.categoryName,
  });

  AllItemsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    timeLostAt = json['timeLostAt'];
    description = json['description'];
    location = json['location'];
    imageUrl = json['imageUrl'];
    userId = json['userId'];
    // status = json['status'];'
    status = _mapStatus(json['status']);
    categoryId = json['categoryId'];
    categoryName = json['category']?['name'];
    if (json['images'] != null &&
        json['images'] is List &&
        json['images'].isNotEmpty) {
      imageUrl = json['images'][0]['url'];
    } else {
      imageUrl = null;
    }
  }

  String _mapStatus(String? backendStatus) {
    if (backendStatus == null) return 'Unknown';
    switch (backendStatus.toUpperCase().trim()) {
      case 'PENDING':
        return 'Pending';
      case 'CHATOWNER':
        return 'In Progress';
      case 'COMPLETED':
        return 'Founded';
      default:
        return backendStatus;
    }
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
    data['status'] = this.status;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;

    if (categoryName != null) {
      data['category'] = {'name': categoryName};
    }
    return data;
  }
}

// class AllItemModel {
//   bool? success;
//   int? statusCode;
//   Data? data;

//   AllItemModel({this.success, this.statusCode, this.data});

//   AllItemModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     statusCode = json['statusCode'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['statusCode'] = this.statusCode;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   int? id;
//   String? type;
//   String? title;
//   String? description;
//   String? location;
//   Null? province;
//   Null? contactnumber;
//   Null? district;
//   String? status;
//   int? userId;
//   Null? rewardBadgeId;
//   String? createdAt;
//   String? updatedAt;
//   String? timeLostAt;
//   int? categoryId;
//   Null? confirmedByPosterId;
//   Null? confirmedByClaimerId;
//   List<Images>? images;
//   Category? category;
//   Null? rewardBadge;

//   Data({
//     this.id,
//     this.type,
//     this.title,
//     this.description,
//     this.location,
//     this.province,
//     this.contactnumber,
//     this.district,
//     this.status,
//     this.userId,
//     this.rewardBadgeId,
//     this.createdAt,
//     this.updatedAt,
//     this.timeLostAt,
//     this.categoryId,
//     this.confirmedByPosterId,
//     this.confirmedByClaimerId,
//     this.images,
//     this.category,
//     this.rewardBadge,
//   });

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     type = json['type'];
//     title = json['title'];
//     description = json['description'];
//     location = json['location'];
//     province = json['province'];
//     contactnumber = json['contactnumber'];
//     district = json['district'];
//     status = json['status'];
//     userId = json['userId'];
//     rewardBadgeId = json['rewardBadgeId'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     timeLostAt = json['timeLostAt'];
//     categoryId = json['categoryId'];
//     confirmedByPosterId = json['confirmedByPosterId'];
//     confirmedByClaimerId = json['confirmedByClaimerId'];
//     if (json['images'] != null) {
//       images = <Images>[];
//       json['images'].forEach((v) {
//         images!.add(new Images.fromJson(v));
//       });
//     }
//     category =
//         json['category'] != null
//             ? new Category.fromJson(json['category'])
//             : null;
//     rewardBadge = json['rewardBadge'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['type'] = this.type;
//     data['title'] = this.title;
//     data['description'] = this.description;
//     data['location'] = this.location;
//     data['province'] = this.province;
//     data['contactnumber'] = this.contactnumber;
//     data['district'] = this.district;
//     data['status'] = this.status;
//     data['userId'] = this.userId;
//     data['rewardBadgeId'] = this.rewardBadgeId;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['timeLostAt'] = this.timeLostAt;
//     data['categoryId'] = this.categoryId;
//     data['confirmedByPosterId'] = this.confirmedByPosterId;
//     data['confirmedByClaimerId'] = this.confirmedByClaimerId;
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     if (this.category != null) {
//       data['category'] = this.category!.toJson();
//     }
//     data['rewardBadge'] = this.rewardBadge;
//     return data;
//   }
// }

// class Images {
//   int? id;
//   String? url;
//   Null? alt;
//   Null? name;
//   String? createdAt;
//   int? userId;
//   int? reportId;

//   Images({
//     this.id,
//     this.url,
//     this.alt,
//     this.name,
//     this.createdAt,
//     this.userId,
//     this.reportId,
//   });

//   Images.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     url = json['url'];
//     alt = json['alt'];
//     name = json['name'];
//     createdAt = json['createdAt'];
//     userId = json['userId'];
//     reportId = json['reportId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['url'] = this.url;
//     data['alt'] = this.alt;
//     data['name'] = this.name;
//     data['createdAt'] = this.createdAt;
//     data['userId'] = this.userId;
//     data['reportId'] = this.reportId;
//     return data;
//   }
// }

// class Category {
//   int? id;
//   String? name;

//   Category({this.id, this.name});

//   Category.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     return data;
//   }
// }
