import 'dart:async';
import 'package:al_dalel/core/configuration/styles.dart';
import 'package:al_dalel/core/loaders/loading_overlay.dart';
import 'package:al_dalel/core/utils.dart';
import 'package:al_dalel/core/utils/size_config.dart';
import 'package:al_dalel/layers/bloc/government_building/government_building_cubit.dart';
import 'package:al_dalel/layers/data/model/place.dart';
import 'package:al_dalel/layers/view/screens/nearest_government_building_screen/widgets/choose_service_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../injection_container.dart';

class NearestGovernmentBuildingScreen extends StatefulWidget {
  const NearestGovernmentBuildingScreen({super.key});

  @override
  State<NearestGovernmentBuildingScreen> createState() =>
      _NearestGovernmentBuildingScreenState();
}

class _NearestGovernmentBuildingScreenState
    extends State<NearestGovernmentBuildingScreen> {
  //final locationController = Location();

  static const damascus = LatLng(33.513548, 36.277839);
  Completer<GoogleMapController> _googleMapController = Completer();
  bool showData = false;
  late Place _selectedPlace;
  final _governmentBuildingCubit = sl<GovernmentBuildingCubit>();

  Set<Marker> marker = {};

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: FloatingActionButton(
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () async {
              final res = await showDialog(
                  context: context, builder: (_) => ChooseServiceDialog());
              if (res != null && res.toString().isNotEmpty) {
                _governmentBuildingCubit.getGovernmentBuilding(
                    33.513548, 36.277839, res);
              }
            },
          ),
        ),
        body: BlocListener<GovernmentBuildingCubit, GovernmentBuildingState>(
          bloc: _governmentBuildingCubit,
          listener: (context, state) async {
            if (state is GovernmentBuildingLoading) {
              LoadingOverlay.of(context).show();
            } else if (state is GovernmentBuildingError) {
              LoadingOverlay.of(context).hide();
              Utils.showSnackBar(context, state.error);
            } else if (state is GovernmentBuildingLoaded) {
              LoadingOverlay.of(context).hide();
              setState(() {
                marker = {
                  Marker(
                    markerId: MarkerId(
                        state.nearestBuilding.building.latitude.toString()),
                    icon: BitmapDescriptor.defaultMarker,
                    position: LatLng(state.nearestBuilding.building.latitude,
                        state.nearestBuilding.building.longitude),
                  ),
                };
              });
              (await _googleMapController.future).animateCamera(
                  CameraUpdate.newLatLngZoom(
                      LatLng(state.nearestBuilding.building.latitude,
                          state.nearestBuilding.building.longitude),
                      18));
            }
          },
          child: Stack(
            children: [
              GoogleMap(
                onMapCreated: (controller) {
                  _googleMapController.complete(controller);
                },
                onTap: (value) {
                  setState(() {
                    showData = false;
                  });
                },
                initialCameraPosition: const CameraPosition(
                  target: damascus,
                  zoom: 13,
                ),
                markers: marker,
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
