import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as gps;

class GoogleMapPage extends StatefulWidget {
  GoogleMapPage({this.latitude, this.longitude, this.onlyView});

  final double? latitude;
  final double? longitude;
  final bool? onlyView;

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late LatLng latLng;
  GoogleMapController? _controller;
  late CameraPosition initialLocation;

  updateLocationMarker(double latitude, double longitude) async {
    this.setState(() {
      latLng = LatLng(latitude, longitude);
    });
    if (_controller != null)
      await _controller?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(latitude, longitude), zoom: 18.00)));

    setState(() {});
  }

  pickLocation() async {
    try {
      final places = await GeocodingPlatform.instance
          .placemarkFromCoordinates(latLng.latitude, latLng.longitude);

      Navigator.pop(context, {
        'lat': latLng.latitude,
        'lon': latLng.longitude,
        'address': places[1].street
      });
    } catch (e) {

      Navigator.pop(context,
          {'lat': latLng.latitude, 'lon': latLng.longitude, 'address': '-'});
    }
  }

  Set<Marker> _markers = Set.from([]);
  BitmapDescriptor? _markerIcon;

  loadMarkerIcon() {
    if (widget.latitude != null)
      BitmapDescriptor.fromAssetImage(
        ImageConfiguration(),
        'images/logo2.png',
      ).then((val) {
        setState(() {
          _markerIcon = val;
          _markers.add(
              Marker(
              markerId: MarkerId('home'),
              position: latLng,
              icon: _markerIcon ?? BitmapDescriptor.defaultMarker));
        });
      });
  }

  @override
  void initState() {
    latLng = LatLng(widget.latitude ?? 24.633333, widget.longitude ??  46.716667);
    initialLocation = CameraPosition(
      target: latLng,
      zoom: 14.5,
    );
    loadMarkerIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 7, right: 7),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(

                Icons.arrow_back_ios,
                color: Color(0xff7B217E),
              ),
            ),
          ),

      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: initialLocation,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) async {
              _controller = controller;
            },
            markers: _markers,
            onCameraMove: (v) {
              if (widget.onlyView != true)
                latLng = LatLng(v.target.latitude, v.target.longitude);
            },
          ),
          widget.onlyView == true
              ? Center()
              : Container(
                  margin: EdgeInsets.only(bottom: 20),
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color:Color(0xff7B217E),
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                      child: Text(
                        'تحديد الموقع',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                      onPressed: () async{
                       await pickLocation();
                      }),
                ),
          Positioned(
            bottom: 87,
            right: 20,
            child: Container(
              height: 60,
              width: 60,
              child: FloatingActionButton(
                  tooltip: 'حدد موقعك الحالي',
                  elevation: 4,
                  backgroundColor:Color(0xff7B217E),

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(
                    Icons.my_location,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    var location = gps.Location();
                    bool serviceEnabled;
                    gps.PermissionStatus permissionGranted;
                    gps.LocationData locationData;

                    serviceEnabled = await location.serviceEnabled();
                    if (!serviceEnabled) {
                      serviceEnabled = await location.requestService();
                      if (!serviceEnabled) {
                        return;
                      }
                    }

                    permissionGranted = await location.hasPermission();
                    if (permissionGranted == gps.PermissionStatus.denied) {
                      permissionGranted = await location.requestPermission();
                      if (permissionGranted != gps.PermissionStatus.granted) {
                        return;
                      }
                    }
                    locationData = await location.getLocation();
                    updateLocationMarker(locationData.latitude ?? 0.0,
                        locationData.longitude ?? 0.0);
                  }),
            ),
          ),
          widget.onlyView == true
              ? Center()
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 55),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/location1.png',scale: 5.sp,color: Color(0xff7B217E)),

                        SizedBox(height: 10),
                        Container(
                            height: 3,
                            width: 17,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  blurRadius: 2,
                                  spreadRadius: 5,
                                  color:Color(0xff7B217E))
                            ])),
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
