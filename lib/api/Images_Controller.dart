import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:new_boulevard/models/detalies.dart';
import '../Shared_Preferences/User_Preferences.dart';
import '../utils/helpers.dart';
import 'api_setting.dart';

class ImagesApiController with Helpers {
  Future<void> uploadImage(BuildContext context,
      {required List<XFile> images,
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
      required void Function(bool status, String massege, Ads ads)
          uploadEvent}) async {
    var url = Uri.parse(ApiSettings.CreateNewAd);
    var multiPartRequest = http.MultipartRequest(
      'POST',
      url,
    );
    multiPartRequest.files
        .add(await http.MultipartFile.fromPath('image', coverimg));

    List<dynamic> result =
        await Future.wait(images.asMap().entries.map((e) async {
      multiPartRequest.files.add(await http.MultipartFile.fromPath(
          'extra_images[${e.key.toString()}]', e.value.path));
    }));
    List<dynamic> vidros =
        await Future.wait(videos.asMap().entries.map((e) async {
      multiPartRequest.files.add(await http.MultipartFile.fromPath(
          'videos[${e.key.toString()}]', e.value));
    }));
    for (int i = 0; i < duration_video.length; i++) {

      multiPartRequest.fields
          .addAll({'duration[$i]': duration_video[i].toString()});
    }

    for (int i = 0; i < height.length; i++) {
      multiPartRequest.fields
          .addAll({'videos_height[$i]': height[i].toString()});
    }
    for (int i = 0; i < width.length; i++) {
      multiPartRequest.fields.addAll({'videos_width[$i]': width[i].toString()});
    }
    multiPartRequest.fields['ad_type_id'] = ad_type_id;
    multiPartRequest.fields['category_id'] = category_id;
    multiPartRequest.fields['city_id'] = city_id;
    multiPartRequest.fields['details_en'] = details_ar;
    multiPartRequest.fields['latitude'] = lat.toString();
    multiPartRequest.fields['longitude'] = lon.toString();
    multiPartRequest.fields['store_url'] = store_url;
    multiPartRequest.fields['facebook'] = facebook;
    multiPartRequest.fields['whatsapp'] = whatsapp;
    multiPartRequest.fields['instagram'] = instagram;
    multiPartRequest.fields['twitter'] = twitter;
    multiPartRequest.headers[HttpHeaders.authorizationHeader] =
        UserPreferences().token;
    multiPartRequest.headers['X-Requested-With'] = 'XMLHttpRequest';
    var response = await multiPartRequest.send();

    response.stream.transform(utf8.decoder).listen((event) {
      if (response.statusCode < 400) {

        print("response");
        print(event);
        var dataObject = jsonDecode(event)["ad"];
        Ads ad = Ads.fromJson(dataObject);
        uploadEvent(true, jsonDecode(event)['message'], ad);
      } else if (response.statusCode != 500) {
        var dataObject = jsonDecode(event)['ad'];
        Ads ad = Ads.fromJson(dataObject);

        showSnackBar(context,
            message: jsonDecode(event)['message'], error: true);
        uploadEvent(false, jsonDecode(event)['message'], ad);
      } else {
        var dataObject = jsonDecode(event)['ad'];
        Ads ad = Ads.fromJson(dataObject);

        showSnackBar(context,
            message: 'Something went wrong, please try again!', error: true);
        uploadEvent(false, jsonDecode(event)['message'], ad);
      }
    });
  }

  Future<void> EditAds(BuildContext context,
      {required List<XFile> images,
      required List<String> videos,
      required String? coverimg,
      required String category_id,
      required String city_id,
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
      required void Function(bool status, String massege) uploadEvent}) async {
    var url = Uri.parse(ApiSettings.updateNewAd);
    var multiPartRequest = http.MultipartRequest(
      'POST',
      url,
    );

    coverimg != null
        ? multiPartRequest.files
            .add(await http.MultipartFile.fromPath('image', coverimg))
        : null;

    if (images.isNotEmpty || images != []) {
      List<dynamic> result =
          await Future.wait(images.asMap().entries.map((e) async {
        multiPartRequest.files.add(await http.MultipartFile.fromPath(
            'extra_images[${e.key.toString()}]', e.value.path));
      }));
    }

    if (videos.isNotEmpty || videos != []) {
      List<dynamic> vidros =
          await Future.wait(videos.asMap().entries.map((e) async {
        multiPartRequest.files.add(await http.MultipartFile.fromPath(
            'videos[${e.key.toString()}]', e.value));
      }));
    }

    if (duration_video.isNotEmpty || duration_video != []) {
      for (int i = 0; i < duration_video.length; i++) {
        multiPartRequest.fields
            .addAll({'duration[$i]': duration_video[i].toString()});
      }
    }

    if (height.isNotEmpty || height != []) {
      for (int i = 0; i < height.length; i++) {
        multiPartRequest.fields
            .addAll({'videos_height[$i]': height[i].toString()});
      }
    }

    if (width.isNotEmpty || width != []) {
      for (int i = 0; i < width.length; i++) {
        multiPartRequest.fields
            .addAll({'videos_width[$i]': width[i].toString()});
      }
    }

    multiPartRequest.fields['category_id'] = category_id;
    multiPartRequest.fields['latitude'] = lat.toString();
    multiPartRequest.fields['longitude'] = lon.toString();
    multiPartRequest.fields['city_id'] = city_id;
    multiPartRequest.fields['details_en'] = details_ar;

    multiPartRequest.fields['ad_id'] = ad_id;
    multiPartRequest.fields['ad_type_id'] = adTypeid.toString();

    multiPartRequest.fields['store_url'] = store_url;
    multiPartRequest.fields['facebook'] = facebook;
    multiPartRequest.fields['whatsapp'] = whatsapp;
    multiPartRequest.fields['instagram'] = instagram;
    multiPartRequest.fields['twitter'] = twitter;
    multiPartRequest.headers[HttpHeaders.authorizationHeader] =
        UserPreferences().token;
    multiPartRequest.headers['X-Requested-With'] = 'XMLHttpRequest';
    var response = await multiPartRequest.send();
    print("response");


    response.stream.transform(utf8.decoder).listen((event) {
      if (response.statusCode < 400) {
        var dataObject = jsonDecode(event)['ad'];
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
}
