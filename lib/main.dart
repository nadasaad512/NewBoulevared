
import 'package:new_boulevard/screens/Details/ad_story_screen.dart';
import 'package:new_boulevard/screens/Home_Screen.dart';
import 'package:new_boulevard/screens/PARTBar/detalies.dart';
import 'package:new_boulevard/screens/PARTBar/partScreen.dart';
import 'package:new_boulevard/screens/Profile/EditAdmain.dart';
import 'package:new_boulevard/screens/Profile/Followers_Advertiser.dart';
import 'package:new_boulevard/screens/Profile/allFollower.dart';
import 'package:new_boulevard/screens/Profile/profileScreen.dart';
import 'package:new_boulevard/screens/SpecialAds/SpeciaScreen.dart';
import 'package:new_boulevard/screens/allAds/Ads.dart';

import 'package:new_boulevard/screens/allAds/new_ads.dart';
import 'package:new_boulevard/screens/auth/ChangePass.dart';
import 'package:new_boulevard/screens/auth/Register_screen.dart';
import 'package:new_boulevard/screens/auth/forgrt_screen.dart';
import 'package:new_boulevard/screens/auth/login_screen.dart';
import 'package:new_boulevard/screens/auth/reset_password_screen.dart';
import 'package:new_boulevard/screens/Award/awards_.dart';
import 'package:new_boulevard/screens/info_screen.dart';
import 'package:new_boulevard/OneStory.dart';
import 'package:new_boulevard/ListStory.dart';
import 'package:new_boulevard/screens/maps/mapscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'MainScreen.dart';
import 'Shared_Preferences/User_Preferences.dart';
import 'Splash.dart';
import 'component/TextField.dart';
import 'conditinScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().initPreferences();
  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return  ScreenUtilInit(
      designSize: Size(375,812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return  MaterialApp(
          localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('ar', 'AE'),
          ],
         locale: Locale('ar', 'AE'),

          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          theme: ThemeData(
            fontFamily: "Cairo"
          ),
          initialRoute: '/launch_screen',
          routes: {
            '/launch_screen': (context) => SplashScreen(),
         //   '/AdvStoryDemo': (context) => Home(),
           // '/YouCanDoit': (context) => StoryPage1(data: 2),
            '/StoryAdsScreen': (context) => StoryAdsScreen(),
            '/NewAdsScreen': (context) => NewAdsScreen(edit: false,indexAd: 2),
            '/MainScreen': (context) => MainScreen(),
            '/HomeScreen': (context) => HomeScreen(),
            '/ConditionScreen': (context) => ConditionScreen(),
            '/AdsScreen': (context) => AdsScreen(),
            '/logain_screen': (context) => LOGAIN_SCREEN(),
            '/register_screen': (context) => RegisterScreen(),
            '/forget_password_screen': (context) => ForgetPasswordScreen(),
            '/PartScreen': (context) => PartScreen(fromnav: true),
            '/SpeciaScreen': (context) => SpeciaScreen(),
            '/ChangePassword': (context) => ChangePassword(),
            '/InfoScreen': (context) => InfoScreen(),
            '/ProfileScreen': (context) => ProfileScreen(),
            '/EditAdmainScreen': (context) => EditAdmainScreen(),
            '/AwardScreen': (context) => AwardScreen(),
            '/GoogleMapPage': (context) => GoogleMapPage(),
         //   '/Followers_Advertiser': (context) => Followers_Advertiser(id: 27),

            '/AdsScreen': (context) => AdsScreen(),




          },


        );
      },

    );






  }
}

