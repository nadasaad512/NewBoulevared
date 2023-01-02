class Autogenerated {
  bool? status;
  int? code;
  String? message;
  Settings? settings;

  Autogenerated({this.status, this.code, this.message, this.settings});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    settings =
        json['settings'] != null ? Settings.fromJson(json['settings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (settings != null) {
      data['settings'] = settings!.toJson();
    }
    return data;
  }
}

class Settings {
  int? id;
  String? url;
  String? whatsapp;
  String? description;
  String? advertisingPolicies;

  Settings();

  Settings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    advertisingPolicies = json['advertisingPolicies'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['advertisingPolicies'] = advertisingPolicies;
    data['whatsapp'] = whatsapp;
    data['description'] = description;
    return data;
  }
}


