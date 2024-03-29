
import 'package:flutter/services.dart';
import 'package:new_boulevard/provider/app_provider.dart';
import 'package:new_boulevard/screens/BestTen/BestTenScreen.dart';
import 'package:new_boulevard/screens/homescreen/Home_Screen.dart';
import 'package:new_boulevard/screens/PARTBar/partScreen.dart';
import 'package:new_boulevard/screens/Profile/ProfileWidgt/EditAdmain.dart';
import 'package:new_boulevard/screens/Profile/ProfileWidgt/profileScreen.dart';
import 'package:new_boulevard/screens/SpecialAds/SpeciaScreen.dart';
import 'package:new_boulevard/screens/allAds/Ads.dart';
import 'package:new_boulevard/screens/allAds/new_ads.dart';
import 'package:new_boulevard/screens/auth/ChangePass.dart';
import 'package:new_boulevard/screens/auth/Register_screen.dart';
import 'package:new_boulevard/screens/auth/forgrt_screen.dart';
import 'package:new_boulevard/screens/auth/login_screen.dart';
import 'package:new_boulevard/screens/Award/awards_.dart';
import 'package:new_boulevard/screens/infoclient/Terms%20and%20Conditions.dart';
import 'package:new_boulevard/screens/infoclient/info_screen.dart';
import 'package:new_boulevard/screens/infoclient/privacy%20policies.dart';
import 'package:new_boulevard/screens/maps/mapscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'screens/mainscreen/MainScreen.dart';
import 'Shared_Preferences/User_Preferences.dart';
import 'screens/Splash/Splash.dart';
import 'screens/infoclient/conditinScreen.dart';




void main() async {
  //HttpOverrides.global = new MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().initPreferences();
  runApp( ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: MyApp()),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: Size(375,812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return  MaterialApp(
          // theme: ThemeData(
          //   primaryColor: Colors.transparent, // Example primary color
          //    // Example accent color
          //   // Define other theme properties here
          // ),
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
          initialRoute: '/launch_screen',
          routes: {
            '/launch_screen': (context) => SplashScreen(),
            '/BestTenScreen': (context) => BestTenScreen(),
            '/LOGAIN_SCREEN': (context) => RegisterScreen(),
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
            '/AdsScreen': (context) => AdsScreen(),
            '/privacypolicies': (context) => privacypolicies(),
            '/TermsandConditions': (context) => TermsandConditions(),





          },


        );
      },

    );






  }
}
// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }

