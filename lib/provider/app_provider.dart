import 'package:flutter/material.dart';

import '../Shared_Preferences/User_Preferences.dart';
import '../api/User_Controller.dart';
import '../models/BestOffers.dart';
import '../models/Follower_user.dart';
import '../models/ads.dart';
import '../models/award.dart';
import '../models/categories.dart';
import '../models/city.dart';
import '../models/detalies.dart';
import '../models/notification.dart';
import '../models/setting.dart';
import '../models/special_ads.dart';
import '../models/user.dart';

class AppProvider extends ChangeNotifier{
  List<MyFollowings> folow = [];
  List<SpecialAds> special_ads = [];
  List<Categories> categories = [];
  List<Categories>? partCategories ;
  List<Ads> BestAds = [];
  List<Banners> banners= [];
  List<notification> massages= [];
  List<Offers> offer= [];
  List<AdvertiserADs> AdmainAd = [];
  List<MyFollowings> FolowUser = [];
  User? user;
  bool HomeLoed=true;
  bool PartScreenLoed=true;
  bool PartAdLoed=true;
  bool AllAdsLoed=true;
  bool ProfileLoed=true;
  bool ProfileAsShownUserLoed=true;
  List<Cities> cit = [];
  List<Ads>? detalies ;
  List<Ads>? PartAd ;
  List<MyFollowings> userfollow = [];
  int ? idcity;
  int ? idpartcity;
  bool filtter=false;
  bool filtterPart=false;
  var selected;
  var selectedPart;
  List<Awards>? award;
  bool AwardsLoed=true;
  bool close =false;
  TextEditingController emailTextController=TextEditingController();
  TextEditingController phoneTextController=TextEditingController();
  bool progss = false;
  List<String?> userFollowFound=[];
  String statusFollow="";
  ///story
  Ads? story ;
  Ads? alldata ;
  Advertiser? advertiser ;
  List<story1>? StroryData ;
  ///
   List<AdType>? Special_Price ;
  List<AdType>? Normal_Price;




  Ads? editAd;




  getAllSpecialAds() async{
    special_ads= await UserApiController().HSpecialAds();
     notifyListeners();
  }
  getAllCategory() async{
    categories= await UserApiController().getCategories();
     notifyListeners();
  }
  getAllPartCategory() async{
    partCategories= await UserApiController().getCategories();
     notifyListeners();
  }
  getAllBestTenAds() async{
    BestAds= await UserApiController().getBestTenAds();
     notifyListeners();
  }
  getAllOffer() async{
    offer= await UserApiController().getBestAds();
     notifyListeners();
  }
  getAllBanner() async{
    banners= await UserApiController().getbaner();
     notifyListeners();
  }
  getAllNotification() async{
    massages= UserPreferences().token!=''?await UserApiController().Notifications():[];
     notifyListeners();
  }
  getAllListStory() async{
    folow=  UserPreferences().user.type=="user"?await UserApiController().Followers_User():[];
    UserPreferences().user.type!="user"?
        null:
     notifyListeners();
  }
  getAllcity() async{
    cit= await UserApiController().getCity();
    notifyListeners();
  }
  getAllAdd() async{
    detalies= filtter?await  UserApiController().ALLADSFiltter(cityid: idcity!):await UserApiController().ALLADS();
    notifyListeners();
  }
  getProfile() async{
    user= await UserApiController().getProfile();
    notifyListeners();
  }
  getAllAward() async{
    award= await UserApiController().Awards_CanWin();
    notifyListeners();
  }

  getAllADS_Admain() async{
    AdmainAd=
    user==null? []:
    await UserApiController().ADS_Admain(userid: user!.id);
    user==null?
        null:
    notifyListeners();
  }
  getAllADS_AdmainForUser({required int id}) async{
    AdmainAd= await UserApiController().ADS_Admain(userid: id);
    notifyListeners();
  }
  getAllUserFollow() async{
    FolowUser=
    user==null?
    []:

    await UserApiController().CountFollowers_User();
    user==null?
    null:
    notifyListeners();
  }


  Future DeletId(BuildContext context, {required int id}) async {
    progss=true;
    notification;
    bool loggedIn = await UserApiController().DeletAds(context, id_dele: id);
    if (loggedIn) {
      progss = false;
      notification;
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }


  getAlldataForStory({required int id}) async{
    story = null;
    alldata = null;


    story= await UserApiController().AdDetalies(idAD:id );
    alldata=story;
    notifyListeners();
    StroryData = List.from(story!.adImages!)
      ..addAll(List.from(story!.adVideos!));
    notifyListeners();
  }


  getPartAds({required int  idcat}) async{
    PartAd=null;
    PartAd= filtterPart?
    await UserApiController().FiltterCity(catId: idcat, cityid:idpartcity!):
    await UserApiController().getDetailes(idcat: idcat);
    notifyListeners();
  }
  getInfoAdmain(int id) async{
    advertiser= await UserApiController().info_Admain(userid: id);
    notifyListeners();
  }

  getUserFolow(int id) async{
    userfollow= await UserApiController().CountFollowers_User();
    userFollowFound= userfollow.map((e) => e.id).toList();
    statusFollow=userFollowFound.contains(id.toString())?"إلغاء متابعة":" متابعة";
    notifyListeners();
  }
  unfollow(int id) async{
     await UserApiController().Follow_One(followed_id: id.toString(), action: "unfollow");
     userFollowFound.remove(id);
    FolowUser.remove(id);
  statusFollow=" متابعة";
   notifyListeners();

  }
  follow(int id) async{
     await UserApiController().Follow_One(followed_id: id.toString(), action: "follow");
      statusFollow="إلغاء متابعة";
   notifyListeners();

  }



  NormalPrice()async{
    Normal_Price=await  UserApiController().Normal_Type();
    notifyListeners();
  }
  SpecialPrice()async{
    Special_Price=await UserApiController().Special_Type();
    notifyListeners();
  }
  EditAds(int id)async{
    editAd=null;
    notifyListeners();
    editAd=await UserApiController().AdDetalies(idAD: id);
    notifyListeners();

  }
}