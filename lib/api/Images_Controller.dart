
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../Shared_Preferences/User_Preferences.dart';
import '../utils/helpers.dart';
import 'api_setting.dart';

class ImagesApiController with Helpers {
  Future<void> uploadImage(BuildContext context,
      {
          required List <XFile> images,
          required List <String> videos,
          required List <double> duration_video,
        required String coverimg,
        required String ad_type_id,
        required String category_id,
        required String city_id,
        required String details_ar,
        required String card_holder_name,
        required String payment_method_id,
        required String card_number,
        required String validation_number,
        required String expired_date,

        required String store_url,
        required double lat,
        required double lon,
        required String facebook,
        required String whatsapp,
        required String instagram,
        required String twitter,
        required void Function(bool status, String massege)uploadEvent


      }

      )
  async {
    var url = Uri.parse(ApiSettings.CreateNewAd);
    var multiPartRequest = http.MultipartRequest('POST', url,);
    multiPartRequest.files.add(await http.MultipartFile.fromPath('image', coverimg));

    List<dynamic> result =await Future.wait(images.asMap().entries.map((e) async {
      multiPartRequest.files.add(await http.MultipartFile.fromPath('extra_images[${e.key.toString()}]', e.value. path));
    }));
    List<dynamic> vidros =await Future.wait(videos.asMap().entries.map((e) async {
      multiPartRequest.files.add(await http.MultipartFile.fromPath('videos[${e.key.toString()}]', e.value));
    }));
    for(int i=0;i<duration_video.length;i++){
      multiPartRequest.fields.addAll({'duration[$i]':duration_video[i].toString()});

    }
    multiPartRequest.fields['ad_type_id']=ad_type_id;
    multiPartRequest.fields['category_id']=category_id;
    multiPartRequest.fields['city_id']=city_id;



    multiPartRequest.fields['details_en']=details_ar;
    multiPartRequest.fields['payment_method_id']=payment_method_id;
    multiPartRequest.fields['card_holder_name']=card_holder_name;
    multiPartRequest.fields['card_number']=card_number;
    multiPartRequest.fields['validation_number']=validation_number;
    multiPartRequest.fields['expired_date']=expired_date;

    multiPartRequest.fields['latitude']=lat.toString();
    multiPartRequest.fields['longitude']=lon.toString();

    multiPartRequest.fields['store_url']=store_url;
    multiPartRequest.fields['facebook']=facebook;
    multiPartRequest.fields['whatsapp']=whatsapp;
    multiPartRequest.fields['instagram']=instagram;
    multiPartRequest.fields['twitter']=twitter;
    multiPartRequest.headers[HttpHeaders.authorizationHeader] = UserPreferences().token;
    multiPartRequest.headers['X-Requested-With'] = 'XMLHttpRequest';
    var response = await multiPartRequest.send();

     response.stream.transform(utf8.decoder).listen((event) {
      if (response.statusCode < 400) {
        var dataObject = jsonDecode(event)['ad'];
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


  Future<void> EditAds(BuildContext context,
      {
        required List <XFile> images,
        required List <String> videos,
        required String coverimg,
        required String ad_type_id,
        required String category_id,
        required String city_id,
        required String details_ar,
        required String card_holder_name,
        required String payment_method_id,
        required String card_number,
        required String validation_number,
        required String expired_date,
        required double lat,
        required double lon,
        required List <double> duration_video,

        required String store_url,
        required String ad_id,
        required String facebook,
        required String whatsapp,
        required String instagram,
        required String twitter,
        required void Function(bool status, String massege)uploadEvent


      }

      )
  async {
    var url = Uri.parse(ApiSettings.updateNewAd);
    var multiPartRequest = http.MultipartRequest('POST', url,);
    multiPartRequest.files.add(await http.MultipartFile.fromPath('image', coverimg));
    List<dynamic> result =await Future.wait(images.asMap().entries.map((e) async {
      multiPartRequest.files.add(await http.MultipartFile.fromPath('extra_images[${e.key.toString()}]', e.value. path));
    }));
    List<dynamic> vidros =await Future.wait(videos.asMap().entries.map((e) async {
      multiPartRequest.files.add(await http.MultipartFile.fromPath('videos[${e.key.toString()}]', e.value));
    }));
    for(int i=0;i<duration_video.length;i++){
      multiPartRequest.fields.addAll({'duration[$i]':duration_video[i].toString()});

    }
    multiPartRequest.fields['ad_type_id']=ad_type_id;
    multiPartRequest.fields['category_id']=category_id;
    multiPartRequest.fields['latitude']=lat.toString();
    multiPartRequest.fields['longitude']=lon.toString();
    multiPartRequest.fields['city_id']=city_id;
    multiPartRequest.fields['details_en']=details_ar;
    multiPartRequest.fields['payment_method_id']=payment_method_id;
    multiPartRequest.fields['card_holder_name']=card_holder_name;
    multiPartRequest.fields['card_number']=card_number;
    multiPartRequest.fields['validation_number']=validation_number;
    multiPartRequest.fields['expired_date']=expired_date;
    multiPartRequest.fields['ad_id']=ad_id;

    multiPartRequest.fields['store_url']=store_url;
    multiPartRequest.fields['facebook']=facebook;
    multiPartRequest.fields['whatsapp']=whatsapp;
    multiPartRequest.fields['instagram']=instagram;
    multiPartRequest.fields['twitter']=twitter;
    multiPartRequest.headers[HttpHeaders.authorizationHeader] = UserPreferences().token;
    multiPartRequest.headers['X-Requested-With'] = 'XMLHttpRequest';
    var response = await multiPartRequest.send();

    response.stream.transform(utf8.decoder).listen((event) {
      if (response.statusCode < 400) {
        var dataObject = jsonDecode(event)['ad'];
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







}


