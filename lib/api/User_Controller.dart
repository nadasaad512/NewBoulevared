import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:new_boulevard/models/notification.dart';
import '../Shared_Preferences/User_Preferences.dart';
import '../models/BestOffers.dart';
import '../models/Folllowers_Advertiser.dart';
import '../models/Follower_user.dart';
import '../models/activity.dart';
import '../models/ads.dart';
import '../models/award.dart';
import '../models/categories.dart';
import '../models/city.dart';
import 'package:new_boulevard/models/special_ads.dart';
import '../models/detalies.dart';
import '../models/notification.dart';
import '../models/notification.dart';
import '../models/setting.dart';
import '../models/story.dart';
import '../models/terms.dart';
import '../models/user.dart';
import '../utils/helpers.dart';
import 'api_setting.dart';
import 'package:http/http.dart' as http;

class UserApiController with Helpers {
  Future<bool> login(BuildContext context, {required String email, required String password}) async {
    var url = Uri.parse(ApiSettings.LOGIN);
    var response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    if (jsonDecode(response.body)['status'] == true) {
      showSnackBar(context, message: "تم تسجيل الدخول بنجاح ", error: false);
      var jsonResponse = jsonDecode(response.body);
      User user = User.fromJson(jsonResponse['user']);
      await UserPreferences().save(user);
      return true;
    } else if (jsonDecode(response.body)['status'] == false) {
      showSnackBar(context,
          message: jsonDecode(response.body)['message'], error: true);
    } else {
      showSnackBar(context,
          message: 'Something went wrong, please try again!', error: true);
    }
    return false;
  }
  Future<bool> DeletAccount(BuildContext context,) async {
    var url = Uri.parse(ApiSettings.AccountDelet);
    var response = await http.get(url,
        headers: {
          HttpHeaders.authorizationHeader: UserPreferences().token,
        },

    );

    if (jsonDecode(response.body)['status'] == true) {
      showSnackBar(context, message: "تم حذف حسابك بنجاح", error: false);
      Navigator.pushReplacementNamed(context, '/launch_screen');
      return true;
    } else if (jsonDecode(response.body)['status'] == false) {
      showSnackBar(context, message: jsonDecode(response.body)['message'], error: true);
    } else {
      showSnackBar(context,
          message: 'Something went wrong, please try again!', error: true);
    }
    return false;
  }

  Future register_AsUser(BuildContext context, User user) async {
    var url = Uri.parse(ApiSettings.REGISTER);
    var response = await http.post(url, body: {
      'type': user.type,
      'name': user.name,
      'email': user.email,
      'password': user.password,
      'confirm_password': user.rememberToken,
      'mobile': user.mobile,
    });

    if (jsonDecode(response.body)['status'] == true) {
      showSnackBar(context, message: jsonDecode(response.body)['message']);
      return true;
    } else if (jsonDecode(response.body)['status'] == false) {
      showSnackBar(context,
          message: jsonDecode(response.body)['message'], error: true);
      return false;
    } else {
      showSnackBar(context,
          message: 'Something went wrong, please try again!', error: true);
    }
  }

  Future register_As_Advertiser(BuildContext context,
      {required String type,
      required String name,
      required String commercialActivities,
      required String password,
      required String surpassword,
      required String mobile,
      required String cityId,
      required String image,
      required String email,
      required void Function(bool status, String massege) uploadEvent}) async {
    var url = Uri.parse(ApiSettings.REGISTER);
    var multiPartRequest = http.MultipartRequest(
      'POST',
      url,
    );
    multiPartRequest.files
        .add(await http.MultipartFile.fromPath('image_profile', image));
    multiPartRequest.fields['type'] = type;
    multiPartRequest.fields['name'] = name;
    multiPartRequest.fields['commercial_activity_id'] = commercialActivities;
    multiPartRequest.fields['email'] = email;
    multiPartRequest.fields['password'] = password;
    multiPartRequest.fields['mobile'] = mobile;
    multiPartRequest.fields['city_id'] = cityId;
    multiPartRequest.fields['confirm_password'] = surpassword;
    multiPartRequest.headers[HttpHeaders.authorizationHeader] =
        UserPreferences().token;
    multiPartRequest.headers['X-Requested-With'] = 'XMLHttpRequest';
    var response = await multiPartRequest.send();
    response.stream.transform(utf8.decoder).listen((event) {
      if (jsonDecode(event)['code'] ==200) {
        var dataObject = jsonDecode(event)['user'];
        showSnackBar(context, message: jsonDecode(event)['message'], error: false);
        uploadEvent(true, jsonDecode(event)['message']);
      } else  {
        showSnackBar(context,
            message: jsonDecode(event)['message'], error: true);
        uploadEvent(false, jsonDecode(event)['message']);
      }
    });
  }

  Future<bool> forgetPassword(BuildContext context,
      {required String email}) async {
    var url = Uri.parse(ApiSettings.reSendCode);
    var response = await http.post(url, body: {'email': email});
    if (jsonDecode(response.body)['status'] == true) {
      showSnackBar(context,
          message: jsonDecode(response.body)['message'], error: false);

      return true;
    } else if (jsonDecode(response.body)['status'] == false) {
      showSnackBar(context,
          message: jsonDecode(response.body)['message'], error: true);
    } else {
      showSnackBar(context,
          message: 'Something went wrong, please try again!', error: true);
    }
    return false;
  }

  Future<bool> ReSendCode(BuildContext context, {required String email}) async {
    var url = Uri.parse(ApiSettings.FORGET_PASSWORD);
    var response = await http.post(url, body: {'email': email});
    if (jsonDecode(response.body)['status'] == true) {
      showSnackBar(context,
          message: jsonDecode(response.body)['message'], error: false);

      return true;
    } else if (jsonDecode(response.body)['status'] == false) {
      showSnackBar(context,
          message: jsonDecode(response.body)['message'], error: true);
    } else {
      showSnackBar(context,
          message: 'Something went wrong, please try again!', error: true);
    }
    return false;
  }

  Future<bool> createNewPassword(
    BuildContext context, {
    required String password,
    required String confirm_password,
    required String email,
    required String code,
  }) async {
    var url = Uri.parse(ApiSettings.createNewPassword);
    var response = await http.post(url, body: {
      'password': password,
      'confirm_password': confirm_password,
      'email': email,
      'code': code,
    }, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().token,
    });
    if (jsonDecode(response.body)['status'] == true) {
      showSnackBar(context,
          message: jsonDecode(response.body)['message'], error: false);
      return true;
    } else if (jsonDecode(response.body)['status'] == false) {
      showSnackBar(context,
          message: jsonDecode(response.body)['message'], error: true);
    } else {
      showSnackBar(context,
          message: 'Something went wrong, please try again!', error: true);
    }
    return false;
  }

  Future<bool> Change_Password(BuildContext context,
      {required String password,
      required String confirm_password,
      required String old_password}) async {
    var url = Uri.parse(ApiSettings.Change_Password);
    var response = await http.post(url, body: {
      'password': password,
      'confirm_password': confirm_password,
      'old_password': old_password
    }, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().token,
    });
    if (jsonDecode(response.body)['status'] == true) {
      showSnackBar(context,
          message: jsonDecode(response.body)['message'], error: false);
      return true;
    } else if (jsonDecode(response.body)['status'] == false) {
      showSnackBar(context,
          message: jsonDecode(response.body)['message'], error: true);
      return false;
    } else {
      showSnackBar(context,
          message: 'Something went wrong, please try again!', error: true);
    }
    return false;
  }

  Future<bool> logout(BuildContext context) async {
    var url = Uri.parse(ApiSettings.LOGOUT);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().token,
    });
    if (jsonDecode(response.body)['status'] == true) {
      await UserPreferences().logout();
      return true;
    } else if (jsonDecode(response.body)['status'] == false) {
      showSnackBar(context,
          message: jsonDecode(response.body)['message'], error: true);
    } else {
      showSnackBar(context,
          message: 'Something went wrong, please try again!', error: true);
    }
    return false;
  }

  Future<List<Cities>> getCity() async {
    var url = Uri.parse(ApiSettings.City);
    var response = await http.get(url);

    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['cities'] as List;
      List<Cities> city =
          jsonArray.map((jsonObject) => Cities.fromJson(jsonObject)).toList();
      return city;
    } else if (jsonDecode(response.body)['status'] == false) {
      print("Something went wrong, please try again!");

      //showSnackBar(context, message: 'Something went wrong, please try again!', error: true);
    } else {
      print("Something went wrong, please try again!");

      // showSnackBar(context, message: jsonDecode(response.body)['message'], error: true);
    }
    return [];
  }

  Future<List<Banners>> getbaner() async {
    var url = Uri.parse(ApiSettings.setting);
    var response = await http.get(url);
    
    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['settings']['banners'] as List;
      List<Banners> city =
         jsonArray.map((jsonObject) => Banners.fromJson(jsonObject)).toList();

      return city;
     
    } else if (jsonDecode(response.body)['status'] == false) {

    
    } else {

      
    }
    return [];
  }

  Future<List<Activity>> Commercial_Activities() async {
    var url = Uri.parse(ApiSettings.CommercialActivities);
    var response = await http.get(url);

    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['cities'] as List;
      List<Activity> activity =
          jsonArray.map((jsonObject) => Activity.fromJson(jsonObject)).toList();
      return activity;
    } else if (jsonDecode(response.body)['status'] == false) {
      print("Something went wrong, please try again!");

      //showSnackBar(context, message: 'Something went wrong, please try again!', error: true);
    } else {
      print("Something went wrong, please try again!");

      // showSnackBar(context, message: jsonDecode(response.body)['message'], error: true);
    }
    return [];
  }

  Future<List<Stores>> Stories() async {
    var url = Uri.parse(ApiSettings.Home);
    var response = await http.get(url);
    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['stores'] as List;
      List<Stores> story =
          jsonArray.map((jsonObject) => Stores.fromJson(jsonObject)).toList();
      return story;
    } else if (jsonDecode(response.body)['status'] == false) {
      print("Something went wrong, please try again!");
      //showSnackBar(context, message: 'Something went wrong, please try again!', error: true);
    } else {
      print("Something went wrong, please try again!");

      // showSnackBar(context, message: jsonDecode(response.body)['message'], error: true);
    }
    return [];
  }

  Future<terms> ConditionLink() async {
    var url = Uri.parse(ApiSettings.Condition);
    var response = await http.get(url);
    if (jsonDecode(response.body)['status'] == true)
    {
      var json = jsonDecode(response.body);
      var jsonArray = json['page'];
      terms page = terms.fromJson(jsonArray);
      return page;

    }
    else {
      terms page = terms();
     return page;
    }

  }
  Future<terms> Security() async {
    var url = Uri.parse(ApiSettings.Security);
    var response = await http.get(url);
    if (jsonDecode(response.body)['status'] == true)
    {
      var json = jsonDecode(response.body);
      var jsonArray = json['page'];
      terms page = terms.fromJson(jsonArray);
      return page;

    }
    else {
      terms page = terms();
      return page;
    }

  }

  Future<List<Categories>> getCategories() async {
    var url = Uri.parse(ApiSettings.Categories);
    var response = await http.get(url);

    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['categories'] as List;
      List<Categories> categories = jsonArray
          .map((jsonObject) => Categories.fromJson(jsonObject))
          .toList();
      return categories;
    } else if (jsonDecode(response.body)['status'] == false) {
      print("Something went wrong, please try again!");
      //showSnackBar(context, message: 'Something went wrong, please try again!', error: true);
    } else {
      print("Something went wrong, please try again!");

      // showSnackBar(context, message: jsonDecode(response.body)['message'], error: true);
    }
    return [];
  }

  Future<List<Ads>> getDetailes({required int idcat}) async {
    var url = Uri.parse(ApiSettings.Detaile_mod(catId: idcat));
    var response = await http.get(url);
    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['ads'] as List;
      List<Ads> detalies =
          jsonArray.map((jsonObject) => Ads.fromJson(jsonObject)).toList();
      return detalies;
    } else if (jsonDecode(response.body)['status'] == false) {
      print("Something went wrong, please try again!");

    } else {
      print("Something went wrong, please try again!");

    }
    return [];
  }

  Future<List<Ads>> FiltterCity(
      {required int catId, required int cityid}) async {
    var url = Uri.parse(ApiSettings.Filter(catId: catId, cityid: cityid));
    var response = await http.get(url);
    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['ads'] as List;
      List<Ads> detalies =
          jsonArray.map((jsonObject) => Ads.fromJson(jsonObject)).toList();
      return detalies;
    } else if (jsonDecode(response.body)['status'] == false) {


    } else {

    }
    return [];
  }

  Future<User?> getProfile() async {
    var url = Uri.parse(ApiSettings.Profile);
    if (UserPreferences().token.isNotEmpty) {
      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: UserPreferences().token,
        "Accept-Language":"ar"

      });
      if (jsonDecode(response.body)['status'] == true) {
        var json = jsonDecode(response.body);
        var jsonArray = json['user'];
        User user = User.fromJson(jsonArray);
        return user;
      }
    } else {
      return null;
    }
    return null;
  }

  Future<bool> Follow_One({
    required String followed_id,
    required String action,
  }) async {
    var url = Uri.parse(ApiSettings.Follow_One);
    var response = await http.post(url, body: {
      'followed_id': followed_id,
      'action': action,
    }, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().token,
    });
    if (jsonDecode(response.body)['status'] == true) {
      return true;
    } else if (jsonDecode(response.body)['status'] == false) {
      return false;
    } else {}
    return false;
  }

  Future EditProfile(BuildContext context,
      {required String Name,
      required String mobile,
      required String email,
      String? img,
      required void Function(bool status, String massege) uploadEvent}) async {
    var url = Uri.parse(ApiSettings.EditProfile);

    var multiPartRequest = http.MultipartRequest(
      'POST',
      url,
    );
    img != null
        ? multiPartRequest.files
            .add(await http.MultipartFile.fromPath('image_profile', img))
        : null;
    multiPartRequest.fields['email'] = email;
    multiPartRequest.fields['mobile'] = mobile;
    multiPartRequest.fields['name'] = Name;
    multiPartRequest.headers[HttpHeaders.authorizationHeader] =
        UserPreferences().token;
    multiPartRequest.headers['X-Requested-With'] = 'XMLHttpRequest';
    var response = await multiPartRequest.send();
    response.stream.transform(utf8.decoder).listen((event) {
      if (response.statusCode < 400) {
        showSnackBar(context, message: jsonDecode(event)['message'], error: false);
        uploadEvent(true, jsonDecode(event)['message']);
      } else if (response.statusCode != 500) {
        showSnackBar(context, message: jsonDecode(event)['message'], error: true);
        uploadEvent(false, jsonDecode(event)['message']);
      } else {
        showSnackBar(context, message: 'Something went wrong, please try again!', error: true);
        uploadEvent(false, jsonDecode(event)['message']);
      }
    });
  }

  Future EditAdmain(BuildContext context,
      {required String Name,
      required String mobile,
      required String email,
      required String city_id,
      required String commercialActivities,
      required String facebook,
      required String whatsapp,
      required String instagram,
      required String twitter,
      required String domain,
      img,
      required void Function(bool status, String massege) uploadEvent}) async {
    var url = Uri.parse(ApiSettings.EditProfile);
    var multiPartRequest = http.MultipartRequest(
      'POST',
      url,
    );
    img != null
        ? multiPartRequest.files
            .add(await http.MultipartFile.fromPath('image_profile', img))
        : null;
    multiPartRequest.fields['email'] = email;
    multiPartRequest.fields['mobile'] = mobile;
    multiPartRequest.fields['name'] = Name;
    multiPartRequest.fields['city_id'] = city_id;
    multiPartRequest.fields['commercial_activity_id'] = commercialActivities;
    multiPartRequest.fields['facebook'] = facebook;
    multiPartRequest.fields['whatsapp'] = whatsapp;
    multiPartRequest.fields['instagram'] = instagram;
    multiPartRequest.fields['twitter'] = twitter;
    multiPartRequest.fields['domain'] = domain;

    multiPartRequest.headers[HttpHeaders.authorizationHeader] =
        UserPreferences().token;
    multiPartRequest.headers['X-Requested-With'] = 'XMLHttpRequest';
    var response = await multiPartRequest.send();
    response.stream.transform(utf8.decoder).listen((event) {
      if (response.statusCode < 400) {
        print(event);
        showSnackBar(context,
            message: jsonDecode(event)['message'], error: false);
        uploadEvent(true, jsonDecode(event)['message']);
      } else if (response.statusCode != 500) {
        showSnackBar(context,
            message: jsonDecode(event)['message'], error: true);
        uploadEvent(false, jsonDecode(event)['message']);
      } else {
        showSnackBar(context,
            message: 'Something went wrong, please try again!', error: true);
        uploadEvent(false, jsonDecode(event)['message']);
      }
    });
  }

  Future<List<Awards>> Awards_CanWin() async {
    var url = Uri.parse(ApiSettings.AwardsCanWin);
    var response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: UserPreferences().token,
      },
    );
    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['awards'] as List;
      List<Awards> awards = jsonArray.map((jsonObject) => Awards.fromJson(jsonObject)).toList();
      print(awards);
      return awards;
    } else if (jsonDecode(response.body)['status'] == false) {
    } else {
    }
    return [];
  }

  Future<bool> AwardRequest(
    BuildContext context, {
    required String mobile,
    required String email,
    required String award_id,
  }) async {
    var url = Uri.parse(ApiSettings.RequestAward);
    var response = await http.post(url, body: {
      'award_id': award_id,
      'mobile': mobile,
      'email': email,
    }, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().token,
    });
    if (jsonDecode(response.body)['status'] == true) {
      showSnackBar(context,
          message: jsonDecode(response.body)['message'], error: false);
      return true;
    } else if (jsonDecode(response.body)['status'] == false) {
      showSnackBar(context,
          message: jsonDecode(response.body)['message'], error: true);
      return false;
    } else {}
    return false;
  }

  Future<List<MyFollowings>> Followers_User() async {
    var url = Uri.parse(ApiSettings.MyFollower);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().token,
    });
    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['myFollowings'] as List;
      List<MyFollowings> folow = jsonArray
          .map((jsonObject) => MyFollowings.fromJson(jsonObject))
          .toList();
      return folow;
    } else if (jsonDecode(response.body)['status'] == false) {

    } else {

    }
    return [];
  }

  Future<List<MyFollowings>> CountFollowers_User() async {
    var url = Uri.parse(ApiSettings.CountMyFollower);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().token,
    });

    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['myFollowings'] as List;
      List<MyFollowings> folow = jsonArray
          .map((jsonObject) => MyFollowings.fromJson(jsonObject))
          .toList();
      return folow;
    } else if (jsonDecode(response.body)['status'] == false) {
    } else {

      // showSnackBar(context, message: jsonDecode(response.body)['message'], error: true);
    }
    return [];
  }

  Future<List<MyFollowers>> Followers_Advertiser(int id) async {
    var url = Uri.parse(ApiSettings.MyFollower_Advertiser(idAdmain: id));
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().token,
    });
    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['myFollowers'] as List;


      List<MyFollowers> folow = jsonArray
          .map((jsonObject) => MyFollowers.fromJson(jsonObject))
          .toList();

      return folow;
    } else if (jsonDecode(response.body)['status'] == false) {
    } else {
    }
    return [];
  }

  Future<List<AdType>> Special_Type() async {
    var url = Uri.parse(ApiSettings.SpecialType);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().token,
    });
    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['adTypes'] as List;
      List<AdType> priceSpe =
          jsonArray.map((jsonObject) => AdType.fromJson(jsonObject)).toList();
      return priceSpe;
    } else if (jsonDecode(response.body)['status'] == false) {
      print("Something went wrong, please try again!");
      //showSnackBar(context, message: 'Something went wrong, please try again!', error: true);
    } else {
      print("Something went wrong, please try again!");

      // showSnackBar(context, message: jsonDecode(response.body)['message'], error: true);
    }
    return [];
  }

  Future<List<AdType>> Normal_Type() async {
    var url = Uri.parse(ApiSettings.NormalType);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().token,
    });
    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['adTypes'] as List;
      List<AdType> priceSpe =
          jsonArray.map((jsonObject) => AdType.fromJson(jsonObject)).toList();
      return priceSpe;
    } else if (jsonDecode(response.body)['status'] == false) {
      print("Something went wrong, please try again!");
      //showSnackBar(context, message: 'Something went wrong, please try again!', error: true);
    } else {
      print("Something went wrong, please try again!");

      // showSnackBar(context, message: jsonDecode(response.body)['message'], error: true);
    }
    return [];
  }

  //list from ad
  Future<List<AdvertiserADs>> ADS_Admain({required int userid}) async {
    var url = Uri.parse(ApiSettings.ADS_Advertiser(admid: userid));
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().token,
    });

    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['advertiserADs'] as List;
      List<AdvertiserADs> ads = jsonArray
          .map((jsonObject) => AdvertiserADs.fromJson(jsonObject))
          .toList();
      return ads;
    }
    return [];
  }

  Future<Advertiser> info_Admain({required int userid}) async {
    var url = Uri.parse(ApiSettings.ADS_Advertiser(admid: userid));
    var response = await http.get(url);
    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['advertiser'];
      Advertiser ads = Advertiser.fromJson(jsonArray);
      return ads;
    } else if (jsonDecode(response.body)['status'] == false) {
      print("Something went wrong, please try again!");
      //showSnackBar(context, message: 'Something went wrong, please try again!', error: true);
    } else {
      print("Something went wrong, please try again!");

      // showSnackBar(context, message: jsonDecode(response.body)['message'], error: true);
    }
    Advertiser ads = Advertiser();
    return ads;
  }

  Future<List<Ads>> ALLADS() async {
    var url = Uri.parse(ApiSettings.AllAds);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().token,
      'X-Requested-With': 'XMLHttpRequest'
    });
    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['ads'] as List;

      print(2);
      List<Ads> detalies =
          jsonArray.map((jsonObject) => Ads.fromJson(jsonObject)).toList();

      return detalies;
    } else if (jsonDecode(response.body)['status'] == false) {
      print(jsonDecode(response.body)['message']);
      //showSnackBar(context, message: 'Something went wrong, please try again!', error: true);
    } else {
      print(jsonDecode(response.body)['message']);
      print("Something went wrong, please try again!");

      // showSnackBar(context, message: jsonDecode(response.body)['message'], error: true);
    }

    return [];
  }

  Future<List<Ads>> ALLADSFiltter({required int cityid}) async {
    var url = Uri.parse(ApiSettings.AllAdsWithfiltter(cityid: cityid));
    var response = await http.get(url);
    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['ads'] as List;
      List<Ads> detalies =
          jsonArray.map((jsonObject) => Ads.fromJson(jsonObject)).toList();
      print(detalies);
      return detalies;
    } else if (jsonDecode(response.body)['status'] == false) {
      print("Something went wrong, please try again!");
      //showSnackBar(context, message: 'Something went wrong, please try again!', error: true);
    } else {
      print("Something went wrong, please try again!");

      // showSnackBar(context, message: jsonDecode(response.body)['message'], error: true);
    }
    return [];
  }

  Future<List<SpecialAds>> HSpecialAds() async {
    var url = Uri.parse(ApiSettings.AllSpecialAds);
    var response = await http.get(url);

    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['special_ads'] as List;
      List<SpecialAds> specialAds = jsonArray
          .map((jsonObject) => SpecialAds.fromJson(jsonObject))
          .toList();
      return specialAds;
    } else if (jsonDecode(response.body)['status'] == false) {
      print("Something went wrong, please try again!");
      //showSnackBar(context, message: 'Something went wrong, please try again!', error: true);
    } else {
      print("Something went wrong, please try again!");

      // showSnackBar(context, message: jsonDecode(response.body)['message'], error: true);
    }
    return [];
  }

  Future<List<Ads>> getBestTenAds() async {
    var url = Uri.parse(ApiSettings.getBestTenAds);
    var response = await http.get(url);

    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['ads'] as List;
      List<Ads> specialAds =
          jsonArray.map((jsonObject) => Ads.fromJson(jsonObject)).toList();
      return specialAds;
    } else if (jsonDecode(response.body)['status'] == false) {

    } else {

    }
    return [];
  }
  Future<List<Offers>> getBestAds() async {
    var url = Uri.parse(ApiSettings.bestads);
    var response = await http.get(url);

    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['offers'] as List;
      List<Offers> specialAds =
          jsonArray.map((jsonObject) => Offers.fromJson(jsonObject)).toList();
      return specialAds;
    } else if (jsonDecode(response.body)['status'] == false) {
    } else {

    }
    return [];
  }
  Future<List<notification>> Notifications() async {
    var url = Uri.parse(ApiSettings.Notifications);
    var response = await http.get(url, headers: {
    HttpHeaders.authorizationHeader: UserPreferences().token,
    });


    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['notifications'] as List;

      List<notification> specialAds =
          jsonArray.map((jsonObject) => notification.fromJson(jsonObject)).toList();
      print("1");
      return specialAds;
    } else if (jsonDecode(response.body)['status'] == false) {
      print("11111");
    } else {
      print("111");

    }
    print("11");
    return [];
  }

  Future<bool> DeletAds(BuildContext context, {required int id_dele}) async {
    var url = Uri.parse(ApiSettings.delet_Ads(dele: id_dele));
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().token,
    });

    if (jsonDecode(response.body)['status'] == true) {
      showSnackBar(context, message: "تم حذف الاعلان بنجاح ", error: false);
      return true;
    } else if (jsonDecode(response.body)['status'] == false) {
      showSnackBar(context,
          message: jsonDecode(response.body)['message'], error: true);
    } else {
      showSnackBar(context,
          message: 'Something went wrong, please try again!', error: true);
    }
    return false;
  }

  Future<bool> DeletAttach({required int id_dele}) async {
    var url = Uri.parse(ApiSettings.delet_Attach(dele: id_dele));
    log(ApiSettings.delet_Attach(dele: id_dele));
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().token,
    });

    return false;
  }

  Future<Ads> AdDetalies({required int idAD}) async {
    var url = Uri.parse(ApiSettings.AdsDetalies(idAds: idAD));
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().token,
    });

    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['ad'];
      Ads ad = Ads.fromJson(jsonArray);
      return ad;
    } else if (jsonDecode(response.body)['status'] == false) {
      print("Something went wrong, please try again!");

    } else {
      print("Something went wrong, please try again!");


    }
    print("Something went wrong, please try again!");
    Ads ad = Ads();
    print("4");
    ad.name = "lhjgj";

    return ad;
  }

  Future<List<story1?>> ListAdVideo({required int idAD}) async {
    var url = Uri.parse(ApiSettings.AdsDetalies(idAds: idAD));
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().token,
    });

    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body)['ad'];

      var jsonArray = json['ad_videos'] as List;
      List<story1> video =
          jsonArray.map((jsonObject) => story1.fromJson(jsonObject)).toList();
      return video;
    } else if (jsonDecode(response.body)['status'] == false) {
      print("Something went wrong, please try again!");
      //showSnackBar(context, message: 'Something went wrong, please try again!', error: true);
    } else {
      print("Something went wrong, please try again!");

      // showSnackBar(context, message: jsonDecode(response.body)['message'], error: true);
    }
    return [];
  }

  Future<Settings> Setting() async {
    var url = Uri.parse(ApiSettings.setting);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().token,
    });

    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['settings'];

      Settings ad = Settings.fromJson(jsonArray);

      return ad;
    } else if (jsonDecode(response.body)['status'] == false) {
    } else {}

    Settings ad = Settings();

    return ad;
  }

  Future<Settings> Condition() async {
    var url = Uri.parse(ApiSettings.setting);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: UserPreferences().token,
    });

    if (jsonDecode(response.body)['status'] == true) {
      var json = jsonDecode(response.body);
      var jsonArray = json['settings'];

      Settings ad = Settings.fromJson(jsonArray);

      return ad;
    } else if (jsonDecode(response.body)['status'] == false) {
    } else {}

    Settings ad = Settings();

    return ad;
  }
}
