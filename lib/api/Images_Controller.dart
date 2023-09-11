import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:new_boulevard/models/detalies.dart';
import 'package:provider/provider.dart';
import '../Shared_Preferences/User_Preferences.dart';
import '../provider/app_provider.dart';
import '../utils/helpers.dart';
import 'api_setting.dart';

class ImagesApiController with Helpers {
  Future<void> uploadImage(BuildContext context, {
    required List<XFile> images,
    required List<String> videos,
    required List<int> height,
    required List<int> width,
    required List<double> duration_video,
    required String coverimg,
    required String ad_type_id,
    required String category_id,
    required String city_id,
    required String details_ar,
    required String store_url,
    required double lat,
    required double lon,
    required String facebook,
    required String whatsapp,
    required String instagram,
    required String twitter,
    required void Function(bool status, String message, Ads ads) uploadEvent,
  }) async {
    final dio = Dio();
    dio.options.headers[HttpHeaders.authorizationHeader] = UserPreferences().token;
    dio.options.headers['X-Requested-With'] = 'XMLHttpRequest';

    try {
      final formData = FormData();

      formData.files.add(MapEntry('image', await MultipartFile.fromFile(coverimg)));

      for (int i = 0; i < images.length; i++) {
        formData.files.add(MapEntry('extra_images[$i]', await MultipartFile.fromFile(images[i].path)));
      }

      for (int i = 0; i < videos.length; i++) {
        formData.files.add(MapEntry('videos[$i]', await MultipartFile.fromFile(videos[i])));
      }

      for (int i = 0; i < duration_video.length; i++) {
        formData.fields.add(MapEntry('duration[$i]', duration_video[i].toString()));
      }

      for (int i = 0; i < height.length; i++) {
        formData.fields.add(MapEntry('videos_height[$i]', height[i].toString()));
      }

      for (int i = 0; i < width.length; i++) {
        formData.fields.add(MapEntry('videos_width[$i]', width[i].toString()));
      }

      formData.fields.add(MapEntry('ad_type_id', ad_type_id));
      formData.fields.add(MapEntry('category_id', category_id));
      formData.fields.add(MapEntry('city_id', city_id));
      formData.fields.add(MapEntry('details_ar', details_ar));
      formData.fields.add(MapEntry('latitude', lat.toString()));
      formData.fields.add(MapEntry('longitude', lon.toString()));
      formData.fields.add(MapEntry('store_url', store_url));
      formData.fields.add(MapEntry('facebook', facebook));
      formData.fields.add(MapEntry('whatsapp', whatsapp));
      formData.fields.add(MapEntry('instagram', instagram));
      formData.fields.add(MapEntry('twitter', twitter));

      final response = await dio.post(ApiSettings.CreateNewAd, data: formData,
        onSendProgress: (int sent, int total) {
          if (total != -1) {
            double percentage = (sent / total) * 100;
            print("sent / total");
            print(sent / total);
            print(percentage);
            Provider.of<AppProvider>(context, listen: false).loeduploedd=sent / total;
            Provider.of<AppProvider>(context, listen: false).loeduploed=percentage.toStringAsFixed(2);
            Provider.of<AppProvider>(context, listen: false).notifyListeners();
            print("Upload progress: ${percentage.toStringAsFixed(2)}%");
          }
        },
      );


      if (response.statusCode == 200) {
       Ads ad = Ads.fromJson(response.data["ad"]);
        uploadEvent(true, response.data["message"], ad);

      } else if (response.statusCode != 500) {
        Ads ad = Ads.fromJson(response.data["ad"]);
        showSnackBar(context, message: response.data['message'], error: true);
        uploadEvent(false, response.data['message'], ad);
      } else {
        Ads ad = Ads.fromJson(response.data["ad"]);
        showSnackBar(context, message: 'Something went wrong, please try again!', error: true);
        uploadEvent(false, response.data['message'], ad);
      }
    } catch (e) {
      print("e");
      print(e.toString());

    }
  }


  Future<void> EditAds(BuildContext context, {
    required List<XFile> images,
    required List<String> videos,
    required String? coverimg,
    required String idCategory,
    required String idCity,
    required String details_ar,
    required double lat,
    required double lon,
    required List<double> duration_video,
    required String store_url,
    required String ad_id,
    required int adTypeid,
    required String facebook,
    required String whatsapp,
    required String instagram,
    required String twitter,
    required List<int> height,
    required List<int> width,
    required void Function(bool status, String message) uploadEvent
  }) async {
    final dio = Dio();
    dio.options.headers[HttpHeaders.authorizationHeader] = UserPreferences().token;
    dio.options.headers['X-Requested-With'] = 'XMLHttpRequest';


    try {
      final formData = FormData();
      if (coverimg != null) {
        formData.files.add(MapEntry('image', await MultipartFile.fromFile(coverimg)));
      }

      if (images.isNotEmpty) {
        for (int i = 0; i < images.length; i++) {
          formData.files.add(MapEntry('extra_images[$i]', await MultipartFile.fromFile(images[i].path)));
        }
      }
      if (videos.isNotEmpty) {
        for (int i = 0; i < videos.length; i++) {
          formData.files.add(MapEntry('videos[$i]', await MultipartFile.fromFile(videos[i])));
        }
      }
      if (duration_video.isNotEmpty) {
        for (int i = 0; i < duration_video.length; i++) {
          formData.fields.add(MapEntry('duration[$i]', duration_video[i].toString()));
        }
      }
      if (height.isNotEmpty) {
        for (int i = 0; i < height.length; i++) {
          formData.fields.add(MapEntry('videos_height[$i]', height[i].toString()));
        }
      }
      if (width.isNotEmpty) {
        for (int i = 0; i < width.length; i++) {
          formData.fields.add(MapEntry('videos_width[$i]', width[i].toString()));
        }
      }
      formData.fields.add(MapEntry('ad_type_id', adTypeid.toString()));
      formData.fields.add(MapEntry('ad_id', ad_id));
      formData.fields.add(MapEntry('category_id', idCategory));
      formData.fields.add(MapEntry('city_id', idCity));
      formData.fields.add(MapEntry('details_ar', details_ar));
      formData.fields.add(MapEntry('latitude',  lat.toString()));
      formData.fields.add(MapEntry('longitude',lon.toString()));
      formData.fields.add(MapEntry('store_url', store_url));
      formData.fields.add(MapEntry('facebook', facebook));
      formData.fields.add(MapEntry('whatsapp', whatsapp));
      formData.fields.add(MapEntry('instagram', instagram));
      formData.fields.add(MapEntry('twitter', twitter));

      final response = await dio.post(ApiSettings.updateNewAd, data: formData,
        onSendProgress: (int sent, int total) {
          if (total != -1) {
            double percentage = (sent / total) * 100;
            print("sent / total");
            print(sent / total);
            print(percentage);
            Provider.of<AppProvider>(context, listen: false).loeduploedd=sent / total;
            Provider.of<AppProvider>(context, listen: false).loeduploed=percentage.toStringAsFixed(2);
            Provider.of<AppProvider>(context, listen: false).notifyListeners();
            print("Upload progress: ${percentage.toStringAsFixed(2)}%");
          }
        },
      );


      if (response.statusCode == 200) {
        showSnackBar(context, message: "تم التعديل بنجاح", error: false);
        uploadEvent(true, "تم التعديل بنجاح");

      } else if (response.statusCode != 500) {
        showSnackBar(context, message: response.data['message'], error: true);
        uploadEvent(false, response.data['message']);
      } else {
        showSnackBar(context, message: response.data['message'], error: true);
        uploadEvent(false, response.data['message']);
      }
    } catch (e) {

    }







  }}
