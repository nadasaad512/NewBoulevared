import 'dart:io';

import 'package:new_boulevard/component/main_bac.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../../api/Images_Controller.dart';
import '../../api/User_Controller.dart';
import '../../component/TextField.dart';
import '../../loed/loed.dart';
import '../../models/ads.dart';
import '../../models/categories.dart';
import '../../models/city.dart';
import '../../models/detalies.dart';
import '../../provider/app_provider.dart';
import '../../utils/helpers.dart';
import '../maps/mapscreen.dart';

class NewAdsScreen extends StatefulWidget {
  bool edit;
  int? indexAd;

  NewAdsScreen({this.edit = false, this.indexAd});

  @override
  State<NewAdsScreen> createState() => _NewAdsScreenState();
}

class _NewAdsScreenState extends State<NewAdsScreen> with Helpers {
  int _currentPage = 0;
  late PageController _pageController;
  late VideoPlayerController controller;
  ImagePicker _imagePicker = ImagePicker();
  PickedFile? _OnepickedFile;
  List<XFile> images = [];
  List<VideoPlayerController> videoList = [];
  List<String> videoList1 = [];
  List<double> duration_video = [];
  List<int> height = [];
  List<int> width = [];
  VideoPlayerController? _videoPlayerController;
  File? _video;
  final picker = ImagePicker();
  bool progg = false;
  final videoInfo = FlutterVideoInfo();
  String location = "الموقع";
  double lat = 0;
  double lon = 0;
  String? EditImage;
  bool EditProgress = false;
  TextEditingController face = TextEditingController();
  TextEditingController twita = TextEditingController();
  TextEditingController whatsup = TextEditingController();
  TextEditingController whatsup2 = TextEditingController();
  TextEditingController insta = TextEditingController();
  TextEditingController link = TextEditingController();
  TextEditingController info = TextEditingController();
  TextEditingController Location = TextEditingController();

  var _selected;
  String? id;
  var _selected1;
  String? idActive;
  int? r;
  int price = 0;
  int? specialindex;
  int? normallindex;
  int? type;
  List<int> num = [];
  List<int> deletItem = [];
  Ads ad = Ads();
  Ads Newad = Ads();
  bool nav = false;
  bool loedEdit = false;
  int navid = 0;
  int adType = 0;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();

    _pageController = PageController();
    controller = VideoPlayerController.network("");
    controller.initialize();
    widget.edit ? loedEdit = true : loedEdit = false;
    widget.edit
        ? UserApiController().AdDetalies(idAD: widget.indexAd!).then((value) {
            setState(() {
              ad = value;
              face.text =ad.facebook==null?"": ad.facebook.toString();
              whatsup.text = ad.whatsapp==null?"": ad.whatsapp.toString();
              insta.text = ad.instagram==null?"":ad.instagram.toString();
              link.text = ad.store_url==null?"":ad.store_url.toString();
              adType = int.parse(ad.adType!.id.toString());
              twita.text = ad.twitter==null?"":ad.twitter.toString();
              idActive = ad.category!.id.toString();
              id = ad.city!.id!.toString();
              info.text = ad.details==null?"":ad.details.toString();
              lat = double.parse(ad.latitude!);
              lon = double.parse(ad.longitude!);
              location = ad.latitude.toString() + ad.longitude.toString();
              _selected1 = ad.category != null ? ad.category!.name.toString() : "";
              _selected = ad.city != null ? ad.city!.name.toString() : "";
              loedEdit = false;
            });
          })
        : null;
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context, listen: false).getAllCategory();
    Provider.of<AppProvider>(context, listen: false).getAllcity();
    Provider.of<AppProvider>(context, listen: false).SpecialPrice();
    Provider.of<AppProvider>(context, listen: false).NormalPrice();

    return Back_Ground(
      Bar: true,
      back: true,
      eror: true,
      childTab: widget.edit ? 'تعديل الإعلان' : "اضافة إعلان",
      child: Container(
          margin: EdgeInsets.only(top: 50.h),
          child: Consumer<AppProvider>(builder: (context, provider, _) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: AlignmentDirectional.centerStart,
                              end: AlignmentDirectional.centerEnd,
                              colors: [
                                Color(0xff7B217E),
                                Color(0xff7B217E),
                                Color(0xff18499A),
                              ]),
                          shape: BoxShape.circle,
                        ),
                        child: num.contains(2)
                            ? Icon(
                                Icons.done_rounded,
                                color: Colors.white,
                                size: 20,
                              )
                            : null),
                    SizedBox(
                      height: 30,
                      width: 60,
                      child: Divider(
                        color: Color(0xffC4C4C4),
                        height: 30,
                        thickness: 2,
                      ),
                    ),
                    Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: AlignmentDirectional.centerStart,
                              end: AlignmentDirectional.centerEnd,
                              colors: [
                                Color(0xff7B217E),
                                Color(0xff7B217E),
                                Color(0xff18499A),
                              ]),
                          shape: BoxShape.circle,
                        ),
                        child: num.contains(1)
                            ? Icon(
                                Icons.done_rounded,
                                color: Colors.white,
                                size: 20,
                              )
                            : null),
                    SizedBox(
                      height: 30,
                      width: 60,
                      child: Divider(
                        color: Color(0xffC4C4C4),
                        height: 30,
                        thickness: 2,
                      ),
                    ),
                    Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: AlignmentDirectional.centerStart,
                              end: AlignmentDirectional.centerEnd,
                              colors: [
                                Color(0xff7B217E),
                                Color(0xff7B217E),
                                Color(0xff18499A),
                              ]),
                          shape: BoxShape.circle,
                        ),
                        child: num.contains(0)
                            ? Icon(
                                Icons.done_rounded,
                                color: Colors.white,
                                size: 20,
                              )
                            : null),
                  ],
                ),
                widget.edit
                    ? Expanded(
                        child: loedEdit
                            ? LoedWidget()
                            : PageView(
                                controller: _pageController,
                                physics: NeverScrollableScrollPhysics(),
                                onPageChanged: (int currentPage) {
                                  setState(() {
                                    _currentPage = currentPage;
                                  });
                                },
                                children: [
                                  provider.isEdit == false
                                      ? Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          child: ListView(
                                            scrollDirection: Axis.vertical,
                                            children: [
                                              Text(
                                                " الصور الخاصة بالاعلان",
                                                style: TextStyle(
                                                    color: Color(0xff7B217E),
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 100.h,
                                                      width: 80.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Color(
                                                              0xff7B217E)),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          await pickImage();
                                                        },
                                                        child: Center(
                                                            child: Icon(
                                                          Icons.add_sharp,
                                                          size: 30.sp,
                                                          color: Colors.white,
                                                        )),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    ad.adImages == [] ||
                                                            ad.adImages ==
                                                                null ||
                                                            ad.adImages!.isEmpty
                                                        ? SizedBox.shrink()
                                                        : SizedBox(
                                                            height: 100.h,
                                                            child: GridView
                                                                .builder(
                                                                    scrollDirection: Axis
                                                                        .horizontal,
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemCount: ad
                                                                        .adImages!
                                                                        .length,
                                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                        childAspectRatio: 100.w /
                                                                            100
                                                                                .h,
                                                                        crossAxisCount:
                                                                            1,
                                                                        mainAxisSpacing: 10
                                                                            .w),
                                                                    itemBuilder:
                                                                        (BuildContext,
                                                                            index) {
                                                                      return Container(
                                                                        width:
                                                                            100.w,
                                                                        height:
                                                                            100.h,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Color(0xff7B217E),
                                                                            borderRadius: BorderRadius.circular(5),
                                                                            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(ad.adImages![index].file.toString()))),
                                                                        child: Align(
                                                                            alignment: Alignment.topLeft,
                                                                            child: Container(
                                                                              margin: EdgeInsets.all(5),
                                                                              child: InkWell(
                                                                                onTap: () async {
                                                                                  var id = ad.adImages![index].id!;
                                                                                  ad.adImages!.removeAt(index);
                                                                                  setState(() {});

                                                                                  await UserApiController().DeletAttach(id_dele: id);
                                                                                },
                                                                                child: CircleAvatar(
                                                                                    backgroundColor: Colors.purple,
                                                                                    radius: 10.sp,
                                                                                    child: Icon(
                                                                                      Icons.close,
                                                                                      size: 10.sp,
                                                                                      color: Colors.white,
                                                                                    )),
                                                                              ),
                                                                            )),
                                                                      );
                                                                    }),
                                                          )
                                                  ],
                                                ),
                                              ),
                                              images.isNotEmpty
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 12.h,
                                                        ),
                                                        Text(
                                                          " الصور المضافة",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff7B217E),
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(
                                                          height: 12.h,
                                                        ),
                                                        SizedBox(
                                                          height: 100.h,
                                                          child:
                                                              GridView.builder(
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemCount:
                                                                      images
                                                                          .length,
                                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                      childAspectRatio: 100
                                                                              .w /
                                                                          100.h,
                                                                      crossAxisCount:
                                                                          1,
                                                                      mainAxisSpacing:
                                                                          10.w),
                                                                  //physics: NeverScrollableScrollPhysics(),
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemBuilder:
                                                                      (BuildContext,
                                                                          index) {
                                                                    return Container(
                                                                      width:
                                                                          100.w,
                                                                      height:
                                                                          100.h,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xff7B217E),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        image: DecorationImage(
                                                                            fit: BoxFit.cover,
                                                                            image: FileImage(
                                                                              File(images[index].path),
                                                                            )),
                                                                      ),
                                                                      child: Align(
                                                                          alignment: Alignment.topLeft,
                                                                          child: Container(
                                                                            margin:
                                                                                EdgeInsets.all(5),
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  images.removeAt(index);
                                                                                });
                                                                              },
                                                                              child: CircleAvatar(
                                                                                  backgroundColor: Colors.purple,
                                                                                  radius: 10.sp,
                                                                                  child: Icon(
                                                                                    Icons.close,
                                                                                    size: 10.sp,
                                                                                    color: Colors.white,
                                                                                  )),
                                                                            ),
                                                                          )),
                                                                    );
                                                                  }),
                                                        ),
                                                      ],
                                                    )
                                                  : SizedBox.shrink(),
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              Text(
                                                " الفيديوهات الخاصة بالاعلان",
                                                style: TextStyle(
                                                    color: Color(0xff7B217E),
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 100.h,
                                                      width: 80.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Color(
                                                              0xff7B217E)),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          await pickvideo();
                                                        },
                                                        child: Center(
                                                            child: Icon(
                                                          Icons.add_sharp,
                                                          size: 30.sp,
                                                          color: Colors.white,
                                                        )),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    ad.adVideos == [] ||
                                                            ad.adVideos ==
                                                                null ||
                                                            ad.adVideos!.isEmpty
                                                        ? SizedBox.shrink()
                                                        : SizedBox(
                                                            height: 100.h,
                                                            child: GridView
                                                                .builder(
                                                                    scrollDirection: Axis
                                                                        .horizontal,
                                                                    itemCount: ad
                                                                        .adVideos!
                                                                        .length,
                                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                        childAspectRatio: 100.w /
                                                                            100
                                                                                .h,
                                                                        crossAxisCount:
                                                                            1,
                                                                        mainAxisSpacing: 10
                                                                            .w),
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemBuilder: (BuildContext, index) {
                                                                      controller = VideoPlayerController.network(ad.adVideos![index].file.toString());
                                                                      controller.initialize();
                                                                      return Container(
                                                                          width: 100
                                                                              .w,
                                                                          height: 100
                                                                              .h,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xff7B217E),
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                          ),
                                                                          child:
                                                                              Stack(
                                                                            children: [
                                                                              SizedBox(
                                                                                height: 100.h,
                                                                                width: 100.w,
                                                                                child: AspectRatio(
                                                                                  aspectRatio: controller.value.aspectRatio,
                                                                                  child: VideoPlayer(controller),
                                                                                ),
                                                                              ),
                                                                              InkWell(
                                                                                onTap: () async {
                                                                                  var id = ad.adVideos![index].id!;
                                                                                  ad.adVideos!.removeAt(index);
                                                                                  setState(() {});
                                                                                  await UserApiController().DeletAttach(id_dele: id);
                                                                                },
                                                                                child: Align(
                                                                                    alignment: Alignment.topLeft,
                                                                                    child: Container(
                                                                                      margin: EdgeInsets.all(5),
                                                                                      child: CircleAvatar(
                                                                                          backgroundColor: Colors.purple,
                                                                                          radius: 10.sp,
                                                                                          child: Icon(
                                                                                            Icons.close,
                                                                                            size: 10.sp,
                                                                                            color: Colors.white,
                                                                                          )),
                                                                                    )),
                                                                              ),
                                                                            ],
                                                                          ));
                                                                    }),
                                                          )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              videoList.isNotEmpty
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 12.h,
                                                        ),
                                                        Text(
                                                          " الفيديوهات المضافة",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff7B217E),
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(
                                                          height: 12.h,
                                                        ),
                                                        SizedBox(
                                                          height: 100.h,
                                                          child:
                                                              GridView.builder(
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemCount:
                                                                      videoList
                                                                          .length,
                                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                      childAspectRatio: 100
                                                                              .w /
                                                                          100.h,
                                                                      crossAxisCount:
                                                                          1,
                                                                      mainAxisSpacing:
                                                                          10.w),
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemBuilder:
                                                                      (BuildContext,
                                                                          index) {
                                                                    return Container(
                                                                        width: 100
                                                                            .w,
                                                                        height: 100
                                                                            .h,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0xff7B217E),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 100.h,
                                                                              width: 100.w,
                                                                              child: AspectRatio(
                                                                                aspectRatio: videoList[index].value.aspectRatio,
                                                                                child: VideoPlayer(videoList[index]),
                                                                              ),
                                                                            ),
                                                                            Center(
                                                                              child: CircleAvatar(
                                                                                radius: 20.sp,
                                                                                backgroundColor: Colors.purple.shade700,
                                                                                child: TextButton(
                                                                                  onPressed: () {
                                                                                    setState(() {
                                                                                      videoList[index].value.isPlaying ? videoList[index].pause() : videoList[index].play();
                                                                                    });
                                                                                  },
                                                                                  child: Icon(
                                                                                    videoList[index].value.isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                                                                                    size: 20.sp,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Container(
                                                                                  margin: EdgeInsets.all(5),
                                                                                  child: InkWell(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        videoList.removeAt(index);
                                                                                      });
                                                                                    },
                                                                                    child: CircleAvatar(
                                                                                        backgroundColor: Colors.purple,
                                                                                        radius: 10.sp,
                                                                                        child: Icon(
                                                                                          Icons.close,
                                                                                          size: 10.sp,
                                                                                          color: Colors.white,
                                                                                        )),
                                                                                  ),
                                                                                )),
                                                                          ],
                                                                        ));
                                                                  }),
                                                        ),
                                                      ],
                                                    )
                                                  : SizedBox.shrink(),
                                              Text(
                                                " الصورة الأساسية لعرض الإعلان",
                                                style: TextStyle(
                                                    color: Color(0xff7B217E),
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 14.h,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 100.h,
                                                    width: 80.w,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color:
                                                            Color(0xff7B217E),
                                                        image: _OnepickedFile !=
                                                                null
                                                            ? DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    FileImage(
                                                                  File(_OnepickedFile!
                                                                      .path),
                                                                ))
                                                            : DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(ad
                                                                    .image
                                                                    .toString()))),
                                                    child: InkWell(
                                                        onTap: () async {
                                                          await OnepickImage();
                                                          setState(() {
                                                            _OnepickedFile ==
                                                                    null
                                                                ? null
                                                                : EditImage =
                                                                    _OnepickedFile!
                                                                        .path;
                                                          });
                                                        },
                                                        child: _OnepickedFile ==
                                                                null
                                                            ? Center(
                                                                child: Icon(
                                                                Icons.add_sharp,
                                                                size: 30.sp,
                                                                color: Colors
                                                                    .white,
                                                              ))
                                                            : null),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 14.h,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.w),
                                                height: 50.h,
                                                width: 343.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(
                                                        color:
                                                            Color(0xffC4C4C4))),
                                                child: DropdownButton(
                                                  isExpanded: true,
                                                  underline: Container(),
                                                  menuMaxHeight: 500.h,
                                                  hint: Text(
                                                    _selected1 == null
                                                        ? "القسم"
                                                        : _selected1,
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color:
                                                            Color(0xffC4C4C4),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  iconEnabledColor:
                                                      Colors.white,
                                                  value: _selected1,
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: Color(0xffC4C4C4),
                                                    size: 18,
                                                  ),
                                                  iconSize: 30,
                                                  elevation: 16,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _selected1 = newValue;
                                                    });
                                                  },
                                                  items: provider.categories
                                                      .map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (Categories value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      onTap: () {
                                                        setState(() {
                                                          idActive = value.id
                                                              .toString();
                                                        });
                                                      },
                                                      value: value.name,
                                                      child: Text(
                                                          value.name != null
                                                              ? value.name!
                                                              : 'اقسام '),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.w),
                                                height: 50.h,
                                                width: 343.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(
                                                        color:
                                                            Color(0xffC4C4C4))),
                                                child: DropdownButton(
                                                  isExpanded: true,
                                                  underline: Container(),
                                                  menuMaxHeight: 500.h,
                                                  hint: Text(
                                                    _selected == null
                                                        ? "المدينة"
                                                        : _selected,
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color:
                                                            Color(0xffC4C4C4),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  iconEnabledColor:
                                                      Colors.white,
                                                  value: _selected,
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: Color(0xffC4C4C4),
                                                    size: 18,
                                                  ),
                                                  iconSize: 30,
                                                  elevation: 16,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _selected = newValue;
                                                    });
                                                  },
                                                  items: provider.cit.map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (Cities value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      onTap: () {
                                                        setState(() {
                                                          id = value.id
                                                              .toString();
                                                        });
                                                      },
                                                      value: value.name,
                                                      child: Text(value.name),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              Text(
                                                "بيانات أخرى - اختيارية",
                                                style: TextStyle(
                                                    color: Color(0xff7B217E),
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 14.h,
                                              ),
                                              SizedBox(
                                                height: 103.h,
                                                width: 343,
                                                child: TextField(
                                                  controller: info,
                                                  maxLines: 30,
                                                  decoration: InputDecoration(
                                                    hintText: 'وصف الإعلان',
                                                    hintStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade500,
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    enabledBorder: _border,
                                                    focusedBorder: _border,
                                                    errorStyle: TextStyle(
                                                      fontSize: 11.sp,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              FieldScreen(
                                                title: "رابط المتجر الالكتروني",
                                                controller: link,
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              SizedBox(
                                                height: 50,
                                                width: 343,
                                                child: InkWell(
                                                    onTap: () async {
                                                      final result =
                                                          await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                GoogleMapPage(
                                                                  onlyView:
                                                                      false,
                                                                  isArrow: true,
                                                                )),
                                                      );
                                                      if (!mounted) return;
                                                      setState(() {
                                                        location =
                                                            result['address'];
                                                      });
                                                      ScaffoldMessenger.of(
                                                          context)
                                                        ..removeCurrentSnackBar()
                                                        ..showSnackBar(SnackBar(
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            backgroundColor:
                                                                Colors.purple
                                                                    .shade900,
                                                            content: Text(
                                                                '${result}')));
                                                      setState(() {
                                                        location =
                                                            result['address'];
                                                        lat = result['lat'];
                                                        lon = result['lon'];
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape
                                                              .rectangle,
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade400),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.w),
                                                        child:
                                                            SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .location_on,
                                                                color: Color(
                                                                    0xff7B217E),
                                                                size: 30.sp,
                                                              ),
                                                              SizedBox(
                                                                width: 10.w,
                                                              ),
                                                              Text(
                                                                location,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500,
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              Text(
                                                "مواقع التواصل - اختيارية",
                                                style: TextStyle(
                                                    color: Color(0xff7B217E),
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 14.h,
                                              ),
                                              FieldScreen(
                                                title: "الفيس بوك",
                                                controller: face,
                                                isicon: true,
                                                icon: "images/facebook.svg",
                                              ),
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              FieldScreen(
                                                title: "",
                                                controller: whatsup,
                                                isicon: true,
                                                icon: "images/whatsapp.svg",
                                              ),
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              FieldScreen(
                                                  title: "الانستجرام",
                                                  controller: insta,
                                                  isicon: true,
                                                  icon: "images/instegram.svg"),
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              FieldScreen(
                                                  title: "تويتر",
                                                  controller: twita,
                                                  isicon: true,
                                                  icon: "images/twitter.svg"),
                                              SizedBox(
                                                height: 22.h,
                                              ),
                                              Center(
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    setState(() {
                                                      EditProgress = true;
                                                    });

                                                    await EditImageFuncation();
                                                    setState(() {
                                                      EditProgress = false;
                                                    });
                                                    _pageController.jumpTo(1);
                                                  },
                                                  child: EditProgress
                                                      ? CircularProgressIndicator(
                                                          color: Colors.white,
                                                        )
                                                      : Text(
                                                          'تعديل',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 18.sp),
                                                        ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Color(0xff7B217E),
                                                    minimumSize: Size(
                                                        double.infinity, 50.h),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 200.h,
                                              ),
                                            ],
                                          ),
                                        )
                                      : SingleChildScrollView(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 90.h,
                                                ),
                                                SvgPicture.asset(
                                                    "images/successads.svg"),
                                                SizedBox(
                                                  height: 39.h,
                                                ),
                                                Text(
                                                  "تم تعديل بيانات الإعلان بنجاح",
                                                  style: TextStyle(
                                                      color: Color(0xff7B217E),
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 90.h,
                                                ),
                                                Center(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/MainScreen');
                                                    },
                                                    child: Text(
                                                      'الذهاب الى الرئيسية',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 18.sp),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Color(0xff7B217E),
                                                      minimumSize:
                                                          Size(160.w, 50.h),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                ],
                              ),
                      )
                    : Expanded(
                        child: PageView(
                          controller: _pageController,
                          physics: NeverScrollableScrollPhysics(),
                          onPageChanged: (int currentPage) {
                            setState(() {
                              _currentPage = currentPage;
                            });
                          },
                          children: [
                            provider.Normal_Price == null ||
                                    provider.Special_Price == null
                                ? LoedWidget()
                                : SingleChildScrollView(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 25.h,
                                          ),
                                          Text(
                                            "اختر نوع الاعلان الخاص بك",
                                            style: TextStyle(
                                                color: Color(0xff7B217E),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 25.h,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 38.h,
                                                    width: 96.w,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xff18499A),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14)),
                                                    child: Center(
                                                      child: Text(
                                                        "إعلان عادي",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 166.w,
                                                    child: GridView.builder(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount: provider
                                                            .Normal_Price!
                                                            .length,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                                childAspectRatio:
                                                                    166.w /
                                                                        54.h,
                                                                crossAxisCount:
                                                                    1,
                                                                // crossAxisSpacing: 13.w,
                                                                mainAxisSpacing:
                                                                    14.h),
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (BuildContext,
                                                                index) {
                                                          return InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                type = provider
                                                                    .Normal_Price![
                                                                        index]
                                                                    .id;
                                                                price = provider
                                                                    .Normal_Price![
                                                                        index]
                                                                    .price!;
                                                                if (specialindex ==
                                                                    null) {
                                                                  normallindex =
                                                                      index;
                                                                } else {
                                                                  specialindex =
                                                                      null;
                                                                  normallindex =
                                                                      index;
                                                                }
                                                              });
                                                              print(index);
                                                            },
                                                            child: Container(
                                                              height: 54.h,
                                                              width: 166,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: normallindex ==
                                                                          index
                                                                      ? Color(
                                                                          0xff18499A)
                                                                      : Color(
                                                                          0xffF9F9F9)),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "${provider.Normal_Price![index].daysCount} يوم",
                                                                    style: TextStyle(
                                                                        fontSize: 16
                                                                            .sp,
                                                                        color: normallindex ==
                                                                                index
                                                                            ? Colors
                                                                                .white
                                                                            : Colors
                                                                                .black,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 18.w,
                                                                  ),
                                                                  Text(
                                                                    "${provider.Normal_Price![index].price} ريال",
                                                                    style: TextStyle(
                                                                        color: normallindex ==
                                                                                index
                                                                            ? Colors
                                                                                .white
                                                                            : Color(
                                                                                0xff7B217E),
                                                                        fontSize: 16
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                width: 11.w,
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 38.h,
                                                    width: 96.w,
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          begin:
                                                              AlignmentDirectional
                                                                  .centerEnd,
                                                          end:
                                                              AlignmentDirectional
                                                                  .centerStart,
                                                          colors: [
                                                            Color(0xff7B217E),
                                                            Color(0xff7B217E),
                                                            Color(0xff18499A),
                                                          ],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14)),
                                                    child: Center(
                                                      child: Text(
                                                        "اعلان مميز",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 166.w,
                                                    child: GridView.builder(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount: provider
                                                            .Special_Price!
                                                            .length,
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                                childAspectRatio:
                                                                    166.w /
                                                                        54.h,
                                                                crossAxisCount:
                                                                    1,
                                                                // crossAxisSpacing: 13.w,
                                                                mainAxisSpacing:
                                                                    14.h),
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (BuildContext,
                                                                index) {
                                                          return InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                price = provider
                                                                    .Special_Price![
                                                                        index]
                                                                    .price!;
                                                                type = provider
                                                                    .Special_Price![
                                                                        index]
                                                                    .id!;
                                                                if (normallindex ==
                                                                    null) {
                                                                  specialindex =
                                                                      index;
                                                                } else {
                                                                  normallindex =
                                                                      null;
                                                                  specialindex =
                                                                      index;
                                                                }
                                                              });
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          16.w),
                                                              height: 54.h,
                                                              width: 166,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: specialindex ==
                                                                          index
                                                                      ? Color(
                                                                          0xff18499A)
                                                                      : Color(
                                                                          0xffF9F9F9)),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "${provider.Special_Price![index].daysCount} يوم",
                                                                    style: TextStyle(
                                                                        color: specialindex ==
                                                                                index
                                                                            ? Colors
                                                                                .white
                                                                            : Colors
                                                                                .black,
                                                                        fontSize: 16
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 18.w,
                                                                  ),
                                                                  Text(
                                                                    "${provider.Special_Price![index].price} ريال",
                                                                    style: TextStyle(
                                                                        color: specialindex ==
                                                                                index
                                                                            ? Colors
                                                                                .white
                                                                            : Color(
                                                                                0xff7B217E),
                                                                        fontSize: 16
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 22.h,
                                          ),
                                          Center(
                                            child: Container(
                                              height: 46.h,
                                              width: 224.w,
                                              decoration: BoxDecoration(
                                                color: Color(0xffC4C4C4),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "السعر الكلي",
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 18.w,
                                                  ),
                                                  Text(
                                                    "${price} ريال",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff7B217E),
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 50.h,
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20.w,
                                                vertical: 10.h),
                                            child: Row(children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    setState(() {
                                                      if (type != null) {
                                                        _pageController
                                                            .jumpToPage(
                                                                _currentPage +
                                                                    1);
                                                        num.add(_currentPage);
                                                        num.add(
                                                            _currentPage + 1);
                                                      } else {
                                                        showSnackBar(context,
                                                            message:
                                                                "أدخل البيانات المطلوبة",
                                                            error: true);
                                                      }
                                                    });
                                                  },
                                                  child: Text(
                                                    'التالي',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18.sp),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Color(0xff7B217E),
                                                    minimumSize: Size(
                                                        double.infinity, 50.h),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            RefreshIndicator(
                              color: Colors.purple,
                              onRefresh: () async {
                                await Future.delayed(
                                    Duration(milliseconds: 1500));
                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                child: nav
                                    ? Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 90.h,
                                            ),
                                            Text(
                                              "التأكيد على الدفع  ",
                                              style: TextStyle(
                                                  color: Color(0xff7B217E),
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 30.h,
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                setState(() {
                                                  progg = true;
                                                });

                                                await UserApiController()
                                                    .AdDetalies(idAD: navid)
                                                    .then((value) {
                                                  if (value.ad_paid == "yes") {
                                                    _pageController.jumpToPage(
                                                        _currentPage + 1);
                                                    num.add(_currentPage);
                                                    num.add(_currentPage + 1);
                                                    num.add(0);
                                                  } else {
                                                    setState(() {
                                                      nav = false;
                                                      progg = false;
                                                    });
                                                    showSnackBar(context,
                                                        message:
                                                            "أدخل بوابة الدفع",
                                                        error: true);
                                                    _pageController
                                                        .jumpToPage(1);
                                                  }
                                                });
                                              },
                                              child: progg
                                                  ? CircularProgressIndicator(
                                                      color: Colors.white,
                                                    )
                                                  : Text(
                                                      'تحقق',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 18.sp),
                                                    ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xff7B217E),
                                                minimumSize:
                                                    Size(double.infinity, 50.h),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : ListView(
                                        children: [
                                          Text(
                                            "أرفق الصور الخاصة بالاعلان",
                                            style: TextStyle(
                                                color: Color(0xff7B217E),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          images.isEmpty
                                              ? Row(
                                                  children: [
                                                    Container(
                                                      height: 100.h,
                                                      width: 80.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Color(
                                                              0xff7B217E)),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          await pickImage();
                                                        },
                                                        child: Center(
                                                            child: Icon(
                                                          Icons.add_sharp,
                                                          size: 30.sp,
                                                          color: Colors.white,
                                                        )),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 100.h,
                                                        width: 80.w,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Color(
                                                                0xff7B217E)),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            await pickImage();
                                                          },
                                                          child: Center(
                                                              child: Icon(
                                                            Icons.add_sharp,
                                                            size: 30.sp,
                                                            color: Colors.white,
                                                          )),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      SizedBox(
                                                        height: 100.h,
                                                        child: GridView.builder(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                images.length,
                                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                childAspectRatio:
                                                                    100.w /
                                                                        100.h,
                                                                crossAxisCount:
                                                                    1,
                                                                mainAxisSpacing:
                                                                    10.w),
                                                            //physics: NeverScrollableScrollPhysics(),
                                                            shrinkWrap: true,
                                                            itemBuilder:
                                                                (BuildContext,
                                                                    index) {
                                                              return Container(
                                                                width: 100.w,
                                                                height: 100.h,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xff7B217E),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  image: DecorationImage(
                                                                      fit: BoxFit.cover,
                                                                      image: FileImage(
                                                                        File(images[index]
                                                                            .path),
                                                                      )),
                                                                ),
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        Container(
                                                                      margin: EdgeInsets
                                                                          .all(
                                                                              5),
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            images.removeAt(index);
                                                                          });
                                                                        },
                                                                        child: CircleAvatar(
                                                                            backgroundColor: Colors.purple,
                                                                            radius: 10.sp,
                                                                            child: Icon(
                                                                              Icons.close,
                                                                              size: 10.sp,
                                                                              color: Colors.white,
                                                                            )),
                                                                      ),
                                                                    )),
                                                              );
                                                            }),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          Text(
                                            "أرفق  الفيديوهات الخاصة بالاعلان",
                                            style: TextStyle(
                                                color: Color(0xff7B217E),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          videoList.isEmpty
                                              ? Row(
                                                  children: [
                                                    Container(
                                                      height: 100.h,
                                                      width: 80.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Color(
                                                              0xff7B217E)),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          await pickvideo();
                                                        },
                                                        child: Center(
                                                            child: Icon(
                                                          Icons.add_sharp,
                                                          size: 30.sp,
                                                          color: Colors.white,
                                                        )),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 100.h,
                                                        width: 80.w,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Color(
                                                                0xff7B217E)),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            await pickvideo();
                                                          },
                                                          child: Center(
                                                              child: Icon(
                                                            Icons.add_sharp,
                                                            size: 30.sp,
                                                            color: Colors.white,
                                                          )),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      videoList.length != []
                                                          ? SizedBox(
                                                              height: 100.h,
                                                              child: GridView
                                                                  .builder(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .horizontal,
                                                                      itemCount:
                                                                          videoList
                                                                              .length,
                                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                          childAspectRatio: 100.w /
                                                                              100
                                                                                  .h,
                                                                          crossAxisCount:
                                                                              1,
                                                                          mainAxisSpacing: 10
                                                                              .w),
                                                                      //physics: NeverScrollableScrollPhysics(),
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemBuilder:
                                                                          (BuildContext,
                                                                              index) {
                                                                        return Container(
                                                                            width: 100
                                                                                .w,
                                                                            height: 100
                                                                                .h,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xff7B217E),
                                                                              borderRadius: BorderRadius.circular(5),
                                                                            ),
                                                                            child:
                                                                                Stack(
                                                                              children: [
                                                                                SizedBox(
                                                                                  height: 100.h,
                                                                                  width: 100.w,
                                                                                  child: AspectRatio(
                                                                                    aspectRatio: videoList[index].value.aspectRatio,
                                                                                    child: VideoPlayer(videoList[index]),
                                                                                  ),
                                                                                ),
                                                                                Center(
                                                                                  child: CircleAvatar(
                                                                                    radius: 20.sp,
                                                                                    backgroundColor: Colors.purple.shade700,
                                                                                    child: TextButton(
                                                                                      onPressed: () {
                                                                                        setState(() {
                                                                                          videoList[index].value.isPlaying ? videoList[index].pause() : videoList[index].play();
                                                                                        });
                                                                                      },
                                                                                      child: Icon(
                                                                                        videoList[index].value.isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                                                                                        size: 20.sp,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                    alignment: Alignment.topLeft,
                                                                                    child: Container(
                                                                                      margin: EdgeInsets.all(5),
                                                                                      child: InkWell(
                                                                                        onTap: () {
                                                                                          setState(() {
                                                                                            videoList.removeAt(index);
                                                                                          });
                                                                                        },
                                                                                        child: CircleAvatar(
                                                                                            backgroundColor: Colors.purple,
                                                                                            radius: 10.sp,
                                                                                            child: Icon(
                                                                                              Icons.close,
                                                                                              size: 10.sp,
                                                                                              color: Colors.white,
                                                                                            )),
                                                                                      ),
                                                                                    )),
                                                                              ],
                                                                            ));
                                                                      }),
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          Text(
                                            "أرفق الصورة الأساسية لعرض الإعلان",
                                            style: TextStyle(
                                                color: Color(0xff7B217E),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 14.h,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 100.h,
                                                width: 80.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Color(0xff7B217E),
                                                    image: _OnepickedFile !=
                                                            null
                                                        ? DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: FileImage(
                                                              File(
                                                                  _OnepickedFile!
                                                                      .path),
                                                            ))
                                                        : null),
                                                child: InkWell(
                                                    onTap: () async {
                                                      await OnepickImage();
                                                    },
                                                    child: _OnepickedFile ==
                                                            null
                                                        ? Center(
                                                            child: Icon(
                                                            Icons.add_sharp,
                                                            size: 30.sp,
                                                            color: Colors.white,
                                                          ))
                                                        : null),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 14.h,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            height: 50.h,
                                            width: 343.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    color: Color(0xffC4C4C4))),
                                            child: DropdownButton(
                                              isExpanded: true,
                                              underline: Container(),
                                              menuMaxHeight: 500.h,
                                              hint: Text(
                                                "القسم",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: Color(0xffC4C4C4),
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              iconEnabledColor: Colors.white,
                                              value: _selected1,
                                              icon: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: Color(0xffC4C4C4),
                                                size: 18,
                                              ),
                                              iconSize: 30,
                                              elevation: 16,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  _selected1 = newValue;
                                                });
                                              },
                                              items: provider.categories.map<
                                                      DropdownMenuItem<String>>(
                                                  (Categories value) {
                                                return DropdownMenuItem<String>(
                                                  onTap: () {
                                                    setState(() {
                                                      idActive =
                                                          value.id.toString();
                                                    });
                                                  },
                                                  value: value.name,
                                                  child: Text(value.name != null
                                                      ? value.name!
                                                      : 'اقسام '),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            height: 50.h,
                                            width: 343.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    color: Color(0xffC4C4C4))),
                                            child: DropdownButton(
                                              isExpanded: true,
                                              underline: Container(),
                                              menuMaxHeight: 500.h,
                                              hint: Text(
                                                "المدينة",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: Color(0xffC4C4C4),
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              iconEnabledColor: Colors.white,
                                              value: _selected,
                                              icon: Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: Color(0xffC4C4C4),
                                                size: 18,
                                              ),
                                              iconSize: 30,
                                              elevation: 16,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  _selected = newValue;
                                                });
                                              },
                                              items: provider.cit.map<
                                                      DropdownMenuItem<String>>(
                                                  (Cities value) {
                                                return DropdownMenuItem<String>(
                                                  onTap: () {
                                                    setState(() {
                                                      id = value.id.toString();
                                                    });
                                                  },
                                                  value: value.name,
                                                  child: Text(value.name),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Text(
                                            "بيانات أخرى - اختيارية",
                                            style: TextStyle(
                                                color: Color(0xff7B217E),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 14.h,
                                          ),
                                          SizedBox(
                                            height: 103.h,
                                            width: 343,
                                            child: TextField(
                                              controller: info,
                                              maxLines: 30,
                                              decoration: InputDecoration(
                                                hintText: 'وصف الإعلان',
                                                hintStyle: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                enabledBorder: _border,
                                                focusedBorder: _border,
                                                errorStyle: TextStyle(
                                                  fontSize: 11.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          FieldScreen(
                                            title: "رابط المتجر الالكتروني",
                                            controller: link,
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: 343,
                                            child: InkWell(
                                                onTap: () async {
                                                  final result =
                                                      await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GoogleMapPage(
                                                              onlyView: false,
                                                              isArrow: true,
                                                            )),
                                                  );
                                                  if (!mounted) return;
                                                  setState(() {
                                                    location =
                                                        result['address'];
                                                  });
                                                  ScaffoldMessenger.of(context)
                                                    ..removeCurrentSnackBar()
                                                    ..showSnackBar(SnackBar(
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        backgroundColor: Colors
                                                            .purple.shade900,
                                                        content:
                                                            Text('${result}')));
                                                  setState(() {
                                                    location =
                                                        result['address'];
                                                    lat = result['lat'];
                                                    lon = result['lon'];
                                                  });
                                                  print("jhfk${lat}");
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade400),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.w),
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.location_on,
                                                            color: Color(
                                                                0xff7B217E),
                                                            size: 30.sp,
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          Text(
                                                            location,
                                                            style: TextStyle(
                                                              color: Colors.grey
                                                                  .shade500,
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Text(
                                            "مواقع التواصل - اختيارية",
                                            style: TextStyle(
                                                color: Color(0xff7B217E),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 14.h,
                                          ),
                                          FieldScreen(
                                            title: "الفيس بوك",
                                            controller: face,
                                            isicon: true,
                                            icon: "images/facebook.svg",
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          FieldScreen(
                                            title: "",
                                            controller: whatsup,
                                            type: TextInputType.phone,
                                            isicon: true,
                                            icon: "images/whatsapp.svg",
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          FieldScreen(
                                              title: "الانستجرام",
                                              controller: insta,
                                              isicon: true,
                                              icon: "images/instegram.svg"),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          FieldScreen(
                                              title: "تويتر",
                                              controller: twita,
                                              isicon: true,
                                              icon: "images/twitter.svg"),
                                          SizedBox(
                                            height: 22.h,
                                          ),
                                          Center(
                                            child: Container(
                                              height: 46.h,
                                              width: 224.w,
                                              decoration: BoxDecoration(
                                                color: Color(0xffC4C4C4),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "السعر الكلي",
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 18.w,
                                                  ),
                                                  Text(
                                                    "${price}ريال ",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff7B217E),
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 28.h,
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20.w,
                                                vertical: 10.h),
                                            child: Row(children: [
                                              Expanded(
                                                  child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _currentPage > 0
                                                        ? _pageController
                                                            .jumpToPage(
                                                                _currentPage -
                                                                    1)
                                                        : null;
                                                    num.remove(1);
                                                    print(num);
                                                  });
                                                },
                                                child: Text(
                                                  'رجوع',
                                                  style: TextStyle(
                                                          color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18.sp),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xff969696),
                                                  minimumSize:
                                                      Size(164.w, 50.h),
                                                ),
                                              )),
                                              SizedBox(
                                                width: 15.w,
                                              ),
                                              Expanded(
                                                child: ElevatedButton(
                                                    onPressed: () async {
                                                      if (_currentPage == 1 &&
                                                          images != null &&
                                                          _OnepickedFile !=
                                                              null &&
                                                          id != null &&
                                                          idActive != null) {
                                                        await uploadImage();
                                                        Provider.of<AppProvider>(context, listen: false).loeduploedd=0.0;
                                                        Provider.of<AppProvider>(context, listen: false).loeduploed="";
                                                        Provider.of<AppProvider>(context, listen: false).notifyListeners();
                                                        Future.delayed(
                                                            Duration.zero, () {
                                                          launch(Newad
                                                                  .paymentURL
                                                                  .toString())
                                                              .then((value) {
                                                            setState(() {
                                                              nav = true;
                                                            });
                                                          });
                                                        });
                                                      } else {
                                                        showSnackBar(context,
                                                            message:
                                                                "أدخل البيانات المطلوبة",
                                                            error: true);
                                                      }
                                                    },
                                                    child:
                                                        progg
                                                            ?

                                                        Center(
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(3.0),
                                                            child: CircularPercentIndicator(
                                                            radius: 30.0,
                                                            lineWidth: 5.0,
                                                            percent: provider.loeduploedd,
                                                            center: Text(provider.loeduploed, style: TextStyle(
                                                               color: Colors.white,
                                                              fontSize: 12.sp
                                                            )),
                                                            progressColor:
                                                              Colors.green,
                                                      ),
                                                          ),
                                                        )
                                                        : Text(
                                                            'اضافة',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 18.sp),
                                                          ),
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Color(0xff7B217E),
                                                      minimumSize: Size(
                                                          double.infinity, 50.h),
                                                    ),
                                                    ),
                                              ),
                                            ]),
                                          ),
                                          SizedBox(
                                            height: 200.h,
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                            Success()
                          ],
                        ),
                      )
              ],
            );
          })),
    );
  }

  Widget Success() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 90.h,
            ),
            SvgPicture.asset("images/successads.svg"),
            SizedBox(
              height: 39.h,
            ),
            Text(
              "تم إضافة بيانات الإعلان بنجاح",
              style: TextStyle(
                  color: Color(0xff7B217E),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              "يمكنك انتظار موافقة ادارة التطبيق على نشر الإعلان",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 90.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/MainScreen');
                  },
                  child: Text(
                    'الذهاب الى الرئيسية',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18,color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff7B217E),
                    minimumSize: Size(160.w, 50.h),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  OutlineInputBorder get _border {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 0.6,
        color: Colors.grey.shade500,
      ),
    );
  }

  Future pickImage() async {
    final List<XFile>? selectedImages = await _imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      images.addAll(selectedImages);
    }
    setState(() {});
  }

  Future OnepickImage() async {
    _OnepickedFile = await _imagePicker.getImage(source: ImageSource.gallery);
    if (_OnepickedFile != null) {
      setState(() {});
    }
  }

  pickvideo() async {
    final video = await picker.getVideo(source: ImageSource.gallery);
    if (video != null) {
      _video = File(video.path);
      var a = await videoInfo.getVideoInfo(_video!.path);
      _videoPlayerController = VideoPlayerController.file(_video!)
        ..initialize().then((value) {
          videoList.add(_videoPlayerController!);
          videoList1.add(_video!.path);
          print(videoList.length);
          duration_video.add(a!.duration!);
          height.add(a.height!);
          width.add(a.width!);
          setState(() {});
          _videoPlayerController!.pause();
        });
    }
  }

  Future uploadImage() async {
    setState(() {
      progg = true;
    });

    await ImagesApiController().uploadImage(context,
        duration_video: duration_video,
        lat: lat,
        lon: lon,
        facebook: face.text,
        whatsapp: "+${whatsup.text}",
        instagram: insta.text,
        twitter: twita.text,
        store_url: link.text,
        images: images,
        videos: videoList1,
        coverimg: _OnepickedFile!.path,
        ad_type_id: type.toString(),
        category_id: idActive.toString(),
        city_id: id.toString(),
        details_ar: info.text,
        width: width,
        height: height, uploadEvent: (status, massege, ad) {
      if (status) {
        setState(() {
          progg = false;
          Newad = ad;
          navid = ad.id!;
        });

        print("id");
        print(ad.id.toString());
        // _pageController.jumpToPage(3);
      } else {
        setState(() {
          progg = false;
        });
      }
    });
  }

  Future EditImageFuncation() async {
    await ImagesApiController().
    EditAds(context,
        duration_video: duration_video,
        ad_id: widget.indexAd.toString(),
        lat: lat,
        lon: lon,
        adTypeid: adType,
        facebook: face.text,
        whatsapp: "+${whatsup.text}",
        instagram: insta.text,
        twitter: twita.text,
        store_url: link.text,
        images: images,
        videos: videoList1,
        coverimg: EditImage,
        idCategory: idActive.toString(),
        idCity: id.toString(),
        details_ar: info.text,
        width: width,
        height: height, uploadEvent: (status, massege) {
      if (status) {
        Provider.of<AppProvider>(context, listen: false).isEdit = true;
        Provider.of<AppProvider>(context, listen: false).notifyListeners();
        _pageController.jumpToPage(1);
        setState(() {
          progg = false;
        });
      } else {
        setState(() {
          progg = false;
        });
      }
    });
  }
}
