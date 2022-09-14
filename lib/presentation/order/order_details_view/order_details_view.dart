import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:food_user/app/constants.dart';
import 'package:food_user/presentation/resources/assets_manager.dart';
import 'package:food_user/presentation/resources/color_manager.dart';
import 'package:food_user/presentation/resources/string_manager.dart';
import 'package:food_user/presentation/resources/styles_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';
import 'package:food_user/presentation/resources/widgets_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../resources/font_manager.dart';

class OrderDetailsView extends StatefulWidget {
  const OrderDetailsView({Key? key}) : super(key: key);

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  final Completer<GoogleMapController> _controller = Completer();
  List<LatLng> polylineCoordinates = [];

  static const LatLng deliveryManPosition =
  LatLng(30.763982307544843, 31.987059275676583);
  static const LatLng destination =
      LatLng(30.763982307544843, 30.947059275676583);
  LocationData? currentLocation;
  // BitmapDescriptor deliveryManIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    getCurrentLocation();
    setCustomMarkerIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      body: SafeArea(
        child: currentLocation == null
            ? const Center(
                child: Center(
                child: CircularProgressIndicator(),
              ))
            : Stack(
                children: [
                  _googleMapsWidget(),
                  Padding(
                    padding: const EdgeInsets.all(AppSize.s12),
                    child: topBarSection(AppStrings.orderTracking, context),
                  ),
                  _dataSheetSection(),
                ],
              ),
      ),
    );
  }

  //Widgets

  Widget _googleMapsWidget() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        zoom: 13.5,
      ),
      markers: {
        Marker(
          markerId: const MarkerId("currentLocation"),
          icon: currentLocationIcon,
          position:
              LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        ),
        // Marker(
        //   markerId: MarkerId("deliveryMan"),
        //   icon: deliveryManIcon,
        //   position: deliveryManPosition,
        // ),
        Marker(
          markerId: MarkerId("destination"),
          icon: destinationIcon,
          position: destination,
        ),

      },
      onMapCreated: (mapController) {
        _controller.complete(mapController);
      },
      polylines: {
        Polyline(
          polylineId: const PolylineId("route"),
          points: polylineCoordinates,
          color: AppColors.primary,
          width: 6,
        ),
      },
    );
  }

  Widget _dataSheetSection() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: AppSize.s240,
        width: double.infinity,
        margin: EdgeInsets.all(AppSize.s16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSize.s24),
        ),
        child: Column(
          children: [
            _topDataSheetSection(),
            _BottomDataSheetSection(),
          ],
        ),
      ),
    );
  }

  //Data Sheet Widgets
  Widget _topDataSheetSection() {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          color: AppColors.paymentColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppSize.s24),
              topLeft: Radius.circular(AppSize.s24))),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSize.s16),
            child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppSize.s12),
                ),
                child: Image.asset(AppAssets.userIcon)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ahmad Ellahsy",
                style: getMediumTextStyle(color: AppColors.white),
              ),
              const SizedBox(
                height: AppSize.s8,
              ),
              Text(
                "Food Rider",
                style: getRegularTextStyle(),
              )
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(AppSize.s16),
            child: Container(
              height: AppSize.s45,
              width: AppSize.s45,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppSize.s12),
              ),
              child: Icon(
                Icons.phone,
                color: AppColors.white,
                size: AppSize.s26,
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _BottomDataSheetSection() {
    return Expanded(
        flex: 2,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSize.s20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primary.withOpacity(.3),
                        child: Icon(
                          Icons.location_on_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: AppSize.s8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Address",
                              style: getRegularTextStyle(),
                            ),
                            const SizedBox(
                              height: AppSize.s4,
                            ),
                            Text(
                              "Giza Governorate,Sheikh Zayed City",
                              style:
                                  getRegularTextStyle(color: AppColors.black),

                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(left: AppSize.s18),
                      child: DottedLine(
                        direction: Axis.vertical,
                        lineLength: AppSize.s40,
                        dashColor: AppColors.primary,
                      )),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primary.withOpacity(.3),
                        child: Icon(
                          Icons.timelapse,
                          color: AppColors.primary,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: AppSize.s8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "DeliveryTime",
                              style: getRegularTextStyle(),
                            ),
                            const SizedBox(
                              height: AppSize.s4,
                            ),
                            Text(
                              "15 min.",
                              style:
                                  getRegularTextStyle(color: AppColors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  //Google Maps Functions
  void getPolyPoints() async {
    getCurrentLocation();
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      AppConstants.googleApiKey,
      PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
        getPolyPoints();
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
        setState(() {});
      },
    );
  }

  void setCustomMarkerIcon() async {
    final Uint8List locationIcon =
        await getBytesFromAsset(AppAssets.locationIcon, 150);
    final Uint8List deliveryIcon =
    await getBytesFromAsset(AppAssets.deliveryManIcon, 150);
    final Uint8List RestaurantIcon =
        await getBytesFromAsset(AppAssets.RestaurantIcon, 150);

    setState(() {
      currentLocationIcon = BitmapDescriptor.fromBytes(locationIcon);
      // deliveryManIcon = BitmapDescriptor.fromBytes(deliveryIcon);
      destinationIcon = BitmapDescriptor.fromBytes(RestaurantIcon);
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
