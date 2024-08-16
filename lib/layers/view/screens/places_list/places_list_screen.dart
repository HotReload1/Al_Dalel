import 'package:al_dalel/core/configuration/styles.dart';
import 'package:al_dalel/core/routing/route_path.dart';
import 'package:al_dalel/layers/data/model/place.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/ui/waiting_widget.dart';
import '../../../../injection_container.dart';
import '../../../bloc/places/places_cubit.dart';

class PlacesListScreen extends StatelessWidget {
  PlacesListScreen({super.key});

  final _placesCubit = sl<PlacesCubit>();
  bool loaded = false;

  _buildPlacesCard(Place place, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(RoutePaths.PlaceDetailScreen, arguments: {"place": place}),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Hero(
                  tag: place.images.first,
                  child: CachedNetworkImage(
                    imageUrl: place.images.first,
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  )),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      place.name,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                    RatingBar.builder(
                      initialRating: place.averageRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20,
                      ignoreGestures: true,
                      unratedColor: Colors.red.shade100,
                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 18,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        CommonSizes.hSmallerSpace,
                        Text(
                          place.theLocation,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '0.2 miles away',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getWidget(PlacesState state) {
    if (state is PlacesLoading) {
      return Center(
        child: WaitingWidget(),
      );
    } else if (state is PlacesError) {
      return Center(
        child: Text(state.error),
      );
    } else if (state is PlacesLoaded) {
      return ListView.builder(
        itemCount: state.places.length,
        itemBuilder: (context, index) {
          Place place = state.places[index];
          return _buildPlacesCard(place, context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesCubit, PlacesState>(
      bloc: _placesCubit,
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            floatingActionButton: Visibility(
              visible: state is PlacesLoaded,
              child: FloatingActionButton(
                onPressed: () {
                  if (state is PlacesLoaded) {
                    Navigator.of(context).pushNamed(RoutePaths.GoogleMapScreen,
                        arguments: {"places": state.places});
                  }
                },
                child: Icon(Icons.location_searching, color: Colors.white),
              ),
            ),
            body: _getWidget(state));
      },
    );
  }
}
