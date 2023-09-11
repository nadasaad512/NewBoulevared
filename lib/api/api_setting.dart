class ApiSettings {
  static const _BASE_URL = 'https://boulevard20.com';
  static const _API_URL = '$_BASE_URL/api/';
  static const City = '${_API_URL}getCities';
  static const AccountDelet = '${_API_URL}deleteMyAccount';
  static const CommercialActivities = '${_API_URL}getCommercialActivities';
  static const LOGIN = '${_API_URL}loginForUsers';
  static const LOGOUT = '${_API_URL}logout';
  static const REGISTER = '${_API_URL}signUpUsers';
  static const FORGET_PASSWORD = '${_API_URL}forgotPassword';
  static const createNewPassword = '${_API_URL}createNewPassword';
  static const Categories = '${_API_URL}getCategories';
  static String Detaile_mod({required int catId}) =>
      '${_API_URL}getAdsByCategory?category_id=$catId';
  static String Filter({required int catId, required cityid}) =>
      '${_API_URL}getAdsByCategory?category_id=$catId&city_id=$cityid';

  static const Change_Password = '${_API_URL}changePassword';
  static const Condition = '${_API_URL}pageDetails?page_id=3';
  static const Security = '${_API_URL}pageDetails?page_id=2';

  static const reSendCode = '${_API_URL}reSendCode';
  static const Profile = '${_API_URL}profile';
  static const Follow_One = '${_API_URL}followOne';

///user
  static const MyFollower = '${_API_URL}getUserFollowings';

  ///admain
  static const CountMyFollower = '${_API_URL}getUserFollowings1';

  static String MyFollower_Advertiser({required idAdmain}) =>
      '${_API_URL}getAdvertiserFollowers?advertiser_id=$idAdmain';

  static const EditProfile = '${_API_URL}editProfile';
  static const AwardsCanWin = '${_API_URL}awardsCanWin';
  static const RequestAward = '${_API_URL}requestAward';
  static const setting = '${_API_URL}settings';
  static const bestads = '${_API_URL}getBestOffers';
  static const Notifications = '${_API_URL}getMyNotifications';
  static const AllSpecialAds = '${_API_URL}getAllSpecialAds';
  static const getBestTenAds = '${_API_URL}getBestTenAds';
  static const CreateNewAd = '${_API_URL}createNewAd';
  static const SpecialType = '${_API_URL}getAdsTypes?type=special';
  static const NormalType = '${_API_URL}getAdsTypes?type=normal';
  static const AllAds = '${_API_URL}getAllAds';
  static const updateNewAd = '${_API_URL}updateNewAd';
  static String AllAdsWithfiltter({required cityid}) =>
      '${_API_URL}getAllAds?city_id=$cityid';
  static String delet_Ads({required dele}) => '${_API_URL}deleteAd?ad_id=$dele';
  static String delet_Attach({required dele}) =>
      '${_API_URL}deleteAdAttach?attach_id=$dele';

  static String ADS_Advertiser({required admid}) =>
      '${_API_URL}viewAdvertiserDetails?advertiser_id=$admid';
  //
  static String AdsDetalies({required idAds}) =>
      '${_API_URL}viewAdsDetails?ad_id=$idAds';
}
