import 'dart:async';
import 'package:al_dalel/core/configuration/styles.dart';
import 'package:al_dalel/core/utils/size_config.dart';
import 'package:al_dalel/layers/data/model/place.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key, required this.places});

  final List<Place> places;

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  //final locationController = Location();

  static const damascus = LatLng(33.513548, 36.277839);
  bool showData = false;
  late Place _selectedPlace;

  @override
  void initState() {
    super.initState();
    print(showData);
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await initializeMap());
  }

  Future<void> initializeMap() async {
    // await fetchLocationUpdates();
    // final coordinates = await fetchPolylinePoints();
    // generatePolyLineFromPoints(coordinates);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              onTap: (value) {
                setState(() {
                  showData = false;
                });
              },
              initialCameraPosition: const CameraPosition(
                target: damascus,
                zoom: 13,
              ),
              markers: widget.places
                  .map(
                    (e) => Marker(
                      onTap: () {
                        setState(() {
                          _selectedPlace = e;
                          showData = true;
                        });
                      },
                      markerId: MarkerId(e.latitude),
                      icon: BitmapDescriptor.defaultMarker,
                      position: LatLng(
                          double.parse(e.latitude), double.parse(e.longitude)),
                    ),
                  )
                  .toSet(),
            ),
            Positioned.directional(
              textDirection: TextDirection.rtl,
              top: 30,
              start: 20,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back),
                style:
                    IconButton.styleFrom(backgroundColor: Styles.colorPrimary),
              ),
            ),
            Positioned.directional(
              textDirection: TextDirection.rtl,
              top: 30,
              end: 20,
              child: showData
                  ? Container(
                      padding: EdgeInsets.all(5),
                      width: SizeConfig.screenWidth * 0.45,
                      height: SizeConfig.screenWidth * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black38,
                                offset: Offset(2.0, 2.0),
                                blurRadius: 6.0)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                width: SizeConfig.screenWidth * 0.45,
                                imageUrl: _selectedPlace.images.first,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          CommonSizes.vSmallestSpace,
                          Text(
                            _selectedPlace.name,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                                height: 1),
                          ),
                          CommonSizes.vSmallestSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBar.builder(
                                initialRating: _selectedPlace.averageRating,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Styles.colorPrimary,
                                ),
                                unratedColor:
                                    Styles.colorPrimary.withOpacity(0.3),
                                ignoreGestures: true,
                                itemSize: 15,
                                onRatingUpdate: (rating) {},
                              ),
                              Text(
                                _selectedPlace.active ? "مفتوح" : "مغلق",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: _selectedPlace.active
                                        ? Colors.green
                                        : Colors.red,
                                    height: 1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
            )
          ],
        ),
      );

// Future<void> fetchLocationUpdates() async {
//   bool serviceEnabled;
//   PermissionStatus permissionGranted;
//
//   serviceEnabled = await locationController.serviceEnabled();
//   if (serviceEnabled) {
//     serviceEnabled = await locationController.requestService();
//   } else {
//     return;
//   }
//
//   permissionGranted = await locationController.hasPermission();
//   if (permissionGranted == PermissionStatus.denied) {
//     permissionGranted = await locationController.requestPermission();
//     if (permissionGranted != PermissionStatus.granted) {
//       return;
//     }
//   }
//
//   locationController.onLocationChanged.listen((currentLocation) {
//     if (currentLocation.latitude != null &&
//         currentLocation.longitude != null) {
//       setState(() {
//         currentPosition = LatLng(
//           currentLocation.latitude!,
//           currentLocation.longitude!,
//         );
//       });
//     }
//   });
// }
//
// Future<List<LatLng>> fetchPolylinePoints() async {
//   final polylinePoints = PolylinePoints();
//
//   final result = await polylinePoints.getRouteBetweenCoordinates(
//     googleMapsApiKey,
//     PointLatLng(googlePlex.latitude, googlePlex.longitude),
//     PointLatLng(mountainView.latitude, mountainView.longitude),
//   );
//
//   if (result.points.isNotEmpty) {
//     return result.points
//         .map((point) => LatLng(point.latitude, point.longitude))
//         .toList();
//   } else {
//     debugPrint(result.errorMessage);
//     return [];
//   }
// }
}
