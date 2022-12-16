import 'package:new_boulevard/models/story.dart';
import 'package:new_boulevard/models/user.dart';

import 'ads.dart';

class Autogenerated {
  bool? status;
  int? code;
  String? message;
  List<SpecialAds>? specialAds;

  Autogenerated({this.status, this.code, this.message, this.specialAds});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['special_ads'] != null) {
      specialAds = <SpecialAds>[];
      json['special_ads'].forEach((v) {
        specialAds!.add(SpecialAds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (specialAds != null) {
      data['special_ads'] = specialAds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SpecialAds {
  int? id;
  int? adTypeId;
  int? userId;
  int? categoryId;
  int? cityId;
  String? image;
  String? status;
  String? name;
  String? details;
  Advertiser? advertiser;
  AdType? adType;
  Category? category;
  City? city;
  List<story1>? adImages;

  SpecialAds();

  SpecialAds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adTypeId = json['ad_type_id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    cityId = json['city_id'];
    image = json['image'];
    status = json['status'];
    name = json['name'];
    details = json['details'];
    advertiser = json['advertiser'] != null
        ? Advertiser.fromJson(json['advertiser'])
        : null;
    adType = json['ad_type'] != null ? AdType.fromJson(json['ad_type']) : null;
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    if (json['ad_images'] != null) {
      adImages = <story1>[];
      json['ad_images'].forEach((v) {
        adImages!.add(story1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ad_type_id'] = adTypeId;
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['city_id'] = cityId;
    data['image'] = image;
    data['status'] = status;
    data['name'] = name;
    data['details'] = details;
    if (advertiser != null) {
      data['advertiser'] = advertiser!.toJson();
    }
    if (adType != null) {
      data['ad_type'] = adType!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    if (adImages != null) {
      data['ad_images'] = adImages!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
