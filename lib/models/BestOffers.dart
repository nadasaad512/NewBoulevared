import 'detalies.dart';

class Offers {
  int? id;
  String? name;
  List<Ads>? ads;

  Offers({this.id, this.name, this.ads});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
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
    if (this.ads != null) {
      data['ads'] = this.ads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}