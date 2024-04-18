// import 'dart:convert';

// class Banners {
//   int id;
//   String randomNumber;
//   String tagId;
//   String title;
//   String webImage;
//   String? appImage;
//   dynamic locationId;
//   dynamic type;
//   dynamic shopId;
//   int productId;
//   int position;
//   int priority;
//   String flatDiscount;
//   String status;

//   Banners({
//     required this.id,
//     required this.randomNumber,
//     required this.tagId,
//     required this.title,
//     required this.webImage,
//     required this.appImage,
//     required this.locationId,
//     required this.type,
//     required this.shopId,
//     required this.productId,
//     required this.position,
//     required this.priority,
//     required this.flatDiscount,
//     required this.status,
//   });

//   factory Banners.fromRawJson(String str) => Banners.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Banners.fromJson(Map<String, dynamic> json) => Banners(
//         id: json["id"],
//         randomNumber: json["random_number"],
//         tagId: json["tag_id"],
//         title: json["title"],
//         webImage: json["web_image"],
//         appImage: json["app_image"],
//         locationId: json["location_id"],
//         type: json["type"],
//         shopId: json["shop_id"],
//         productId: json["product_id"],
//         position: json["position"],
//         priority: json["priority"],
//         flatDiscount: json["flat_discount"],
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "random_number": randomNumber,
//         "tag_id": tagId,
//         "title": title,
//         "web_image": webImage,
//         "app_image": appImage,
//         "location_id": locationId,
//         "type": type,
//         "shop_id": shopId,
//         "product_id": productId,
//         "position": position,
//         "priority": priority,
//         "flat_discount": flatDiscount,
//         "status": status,
//       };
// }

class BannerModel {
  final int id;
  final String randomNumber;
  final String tagId;
  final String title;
  final String webImage;
  final String? appImage;
  final int? locationId;
  final String? type;
  final int? shopId;
  final int productId;
  final int position;
  final int priority;
  final String flatDiscount;
  final String status;

  BannerModel({
    required this.id,
    required this.randomNumber,
    required this.tagId,
    required this.title,
    required this.webImage,
    required this.appImage,
    required this.locationId,
    required this.type,
    required this.shopId,
    required this.productId,
    required this.position,
    required this.priority,
    required this.flatDiscount,
    required this.status,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      randomNumber: json['random_number'],
      tagId: json['tag_id'],
      title: json['title'],
      webImage: json['web_image'],
      appImage: json['app_image'],
      locationId: json['location_id'],
      type: json['type'],
      shopId: json['shop_id'],
      productId: json['product_id'],
      position: json['position'],
      priority: json['priority'],
      flatDiscount: json['flat_discount'],
      status: json['status'],
    );
  }
}
