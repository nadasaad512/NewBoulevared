import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Shared_Preferences/User_Preferences.dart';
import '../../provider/app_provider.dart';
class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadDataAndNavigate();
  }
  Future<void> loadDataAndNavigate() async {
    await Future.delayed(Duration(seconds: 3)); // Add a 3-second delay

    // Load data using Provider
    Provider.of<AppProvider>(context, listen: false).getAllBanner();
    Provider.of<AppProvider>(context, listen: false).getAllCategory();
    Provider.of<AppProvider>(context, listen: false).getAllSpecialAds();
    Provider.of<AppProvider>(context, listen: false).getAllBestTenAds();
    Provider.of<AppProvider>(context, listen: false).getAllOffer();
    UserPreferences().token!=''?Provider.of<AppProvider>(context, listen: false).getAllNotification():null;
    UserPreferences().token!=''?  Provider.of<AppProvider>(context, listen: false).getAllListStory():null;
    Provider.of<AppProvider>(context, listen: false).HomeLoed=false;


    // Navigate to the MainScreen
    Navigator.pushReplacementNamed(context, '/MainScreen');

  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.black,
     body: Center(
       child: Image.asset("images/splashLogo.png",fit: BoxFit.cover),
     )
   );
  }
}