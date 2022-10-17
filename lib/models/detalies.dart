import 'package:new_boulevard/models/ads.dart';
import 'package:new_boulevard/models/special_ads.dart';
import 'package:new_boulevard/models/story.dart';
import 'package:new_boulevard/models/user.dart';

class Autogenerated {
  bool? status;
  int? code;
  String? message;
  List<Ads>? ads;

  Autogenerated({this.status, this.code, this.message, this.ads});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['ads'] != null) {
      ads = <Ads>[];
      json['ads'].forEach((v) {
        ads!.add(new Ads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.ads != null) {
      data['ads'] = this.ads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ads {

  int? id;
  int? adTypeId;
  int? userId;
  int? categoryId;
  int? cityId;
  String? image;
  String? status;
  String? latitude;
  String? longitude;
  String? store_url;
  String? facebook;
  String? whatsapp;
  String? instagram;
  String? twitter;
  String? name;
  String? details;
  Advertiser? advertiser;
  AdType? adType;
  Category? category;
  City? city;
  List<story1>? adImages;
  List<story1>? adVideos;

  Ads();

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adTypeId = json['ad_type_id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    cityId = json['city_id'];
    image = json['image'];

    store_url = json['store_url'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    whatsapp = json['whatsapp'];
    latitude = json['latitude'];
    longitude = json['longitude'];

    status = json['status'];
    name = json['name'];
    details = json['details'];
    advertiser = json['advertiser'] != null
        ? new Advertiser.fromJson(json['advertiser'])
        : null;
    adType =
    json['ad_type'] != null ? new AdType.fromJson(json['ad_type']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    if (json['ad_images'] != null) {
      adImages = <story1>[];
      json['ad_images'].forEach((v) {
        adImages!.add(new story1.fromJson(v));
      });
    }
    if (json['ad_videos'] != null) {
      adVideos = <story1>[];
      json['ad_videos'].forEach((v) {
        adVideos!.add(new story1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ad_type_id'] = this.adTypeId;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['city_id'] = this.cityId;
    data['image'] = this.image;
    data['status'] = this.status;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;

    data['store_url']=this.store_url;
     data['facebook']=this.facebook;
     data['twitter']=this.twitter;
     data['instagram']=this.instagram;
     data['whatsapp']=this.whatsapp;


    data['name'] = this.name;
    data['details'] = this.details;
    if (this.advertiser != null) {
      data['advertiser'] = this.advertiser!.toJson();
    }
    if (this.adType != null) {
      data['ad_type'] = this.adType!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.adImages != null) {
      data['ad_images'] = this.adImages!.map((v) => v.toJson()).toList();
    }
    if (this.adVideos != null) {
      data['ad_videos'] = this.adVideos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}





