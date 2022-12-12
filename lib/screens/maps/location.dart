import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as gps;

class location extends StatefulWidget {
  location({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;


  @override
  _locationState createState() => _locationState();
}

class _locationState extends State<location> {
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



  Set<Marker> _markers = Set.from([]);
  BitmapDescriptor? _markerIcon;
 String? FullAddress;




  @override
  void initState() {
 GeocodingPlatform.instance.placemarkFromCoordinates(widget.latitude, widget.longitude).then((value) {
   setState(() {
     FullAddress=value[0].name.toString();
   });
   print(value[0].name.toString());

 });




    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(

          size: Size(100,100)),
      'images/XMLID_214_.png',
    ).then((value) {
      _markers.add(
          Marker( //add start location marker
            markerId: MarkerId('home'),
            position: LatLng(widget.latitude, widget.longitude),
            infoWindow: InfoWindow( //popup info
              title:  FullAddress,
              snippet: " ",
            ),
            icon: value, //Icon for Marker
          )
      );
      setState(() {
        _markers;
      });
    });


    latLng = LatLng(widget.latitude , widget.longitude );
    initialLocation = CameraPosition(
      target: latLng,
      zoom: 14.5,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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

          ),
        ],
      ),
    );
  }
}
