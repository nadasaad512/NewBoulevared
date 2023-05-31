class Autogenerated {
  bool? status;
  int? code;
  String? message;
  List<Awards>? awards;

  Autogenerated({this.status, this.code, this.message, this.awards});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['awards'] != null) {
      awards = <Awards>[];
      json['awards'].forEach((v) {
        awards!.add(Awards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (awards != null) {
      data['awards'] = awards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Awards {
  int? id;
  int? pointsCount;
  String? prizeDrawDate;
  String? image;
  String? status;
  int? isRequested;
  String? name;
  String? details;

  Awards(
      {this.id,
      this.pointsCount,
      this.prizeDrawDate,
      this.image,
      this.status,
      this.isRequested,
      this.name,
      this.details});

  Awards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pointsCount = json['points_count'];
    prizeDrawDate = json['prize_draw_date'];
    image = json['image'];
    status = json['status'];
    isRequested = json['is_requested'];
    name = json['name'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['points_count'] = pointsCount;
    data['prize_draw_date'] = prizeDrawDate;
    data['image'] = image;
    data['status'] = status;
    data['is_requested'] = isRequested;
    data['name'] = name;
    data['details'] = details;
    return data;
  }
}
