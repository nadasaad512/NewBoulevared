import 'detalies.dart';

class Autogenerated {
  bool? status;
  int? code;
  String? message;
  List<MyFollowings>? myFollowings;

  Autogenerated({this.status, this.code, this.message, this.myFollowings});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['myFollowings'] != null) {
      myFollowings = <MyFollowings>[];
      json['myFollowings'].forEach((v) {
        myFollowings!.add(new MyFollowings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.myFollowings != null) {
      data['myFollowings'] = this.myFollowings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyFollowings {
  int? id;
  String? name;
  String? imageProfile;
  int? followMeCount;
  List<Ads>? ads;

  MyFollowings({this.id, this.name, this.imageProfile, this.followMeCount});

  MyFollowings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageProfile = json['image_profile'];
    followMeCount = json['follow_me_count'];
    if (json['ads'] != null) {
      ads = <Ads>[];
      json['ads'].forEach((v) {
        ads!.add(new Ads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image_profile'] = this.imageProfile;
    data['follow_me_count'] = this.followMeCount;
    if (this.ads != null) {
      data['ads'] = this.ads!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}