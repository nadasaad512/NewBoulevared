import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Shared_Preferences/User_Preferences.dart';
import '../api/User_Controller.dart';
import '../models/BestOffers.dart';
import '../models/Follower_user.dart';
import '../models/activity.dart';
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
  List<Ads>? BestAds ;
  List<Banners> banners= [];
  List<notification> massages= [];
  List<Offers>? offer;
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
  List<Activity> ActiveList = [];
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
  bool isEdit =false;

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

     bool isLogin=false;
   TextEditingController emailTextControllerl=TextEditingController();
   TextEditingController passwordTextController=TextEditingController();

  TextEditingController ANameTextController = TextEditingController();
  TextEditingController AemailTextController = TextEditingController();
  TextEditingController ApasswordTextController = TextEditingController();
  TextEditingController ASurepasswordTextController = TextEditingController();
  TextEditingController AphoneTextController = TextEditingController();
  TextEditingController NameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController LpasswordTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController SurepasswordTextController = TextEditingController();
  bool Uprogss = false;
  bool Aprogss = false;
  String gender = "user";
  ImagePicker imagePicker = ImagePicker();
  PickedFile? pickedFile;
  User get userdata {
    User user = User();
    user.name = NameTextController.text;
    user.email = emailTextController.text;
    user.password = LpasswordTextController.text;
    user.mobile = phoneTextController.text;
    user.type = gender;
    user.rememberToken = SurepasswordTextController.text;
    notifyListeners();

    return user;
  }
  var selectedActivity;
  var selectedCity;
  String ? id;
  String ? idActive;
  bool check = false;

  Future register_Advertiser(BuildContext context) async {


    await UserApiController().register_As_Advertiser(
        context,
        name: ANameTextController.text,
        email :AemailTextController.text,
        password : ApasswordTextController.text,
        mobile : AphoneTextController.text,
        type : gender,
        commercialActivities:idActive!,
        cityId: id!,
        image:pickedFile!.path,
        surpassword: ASurepasswordTextController.text,
        uploadEvent: (status,massege){
          if(status){
            Navigator.pushNamed(context, '/logain_screen');
            ANameTextController.clear();
            AemailTextController.clear();
            ApasswordTextController.clear();
            AphoneTextController.clear();
            ANameTextController.clear();
            ASurepasswordTextController.clear();
            pickedFile=null;
            id=null;
            idActive=null;
            Aprogss=false;
            check=false;
              notifyListeners();
          }else{
            ANameTextController.clear();
            AemailTextController.clear();
            ApasswordTextController.clear();
            AphoneTextController.clear();
            ANameTextController.clear();
            ASurepasswordTextController.clear();
            Aprogss=false;
            check=false;
            pickedFile=null;
            id=null;
            idActive=null;
            notifyListeners();

          }

        }



    );


  }
  Future pickImage() async {
    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
     notifyListeners();

    }
  }


   register_AsUser(BuildContext context) async {
    bool loggedIn = await UserApiController().register_AsUser(context, userdata);
    if (loggedIn) {
      Navigator.pushNamed(context, '/logain_screen');
      NameTextController.clear();
      emailTextController.clear();
      LpasswordTextController.clear();
      phoneTextController.clear();
      NameTextController.clear();
      SurepasswordTextController.clear();
      Uprogss = false;
      check=false;
      notifyListeners();
    } else {
        Uprogss = false;
        check=false;
        notifyListeners();

    }

    return loggedIn;
  }


login(BuildContext context) async {
    bool loggedIn = await UserApiController().login(context,
        email: emailTextControllerl.text,
        password: passwordTextController.text);

    if (loggedIn) {
      Navigator.pushReplacementNamed(context, '/MainScreen');
      emailTextControllerl.clear();
      passwordTextController.clear();
      isLogin = false;
      notifyListeners();
    } else {
        isLogin = false;
        notifyListeners();
    }
  }


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
  getAllActivey() async{
    ActiveList= await UserApiController().Commercial_Activities();
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