import 'package:al_dalel/core/configuration/styles.dart';
import 'package:al_dalel/layers/data/model/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../widgets/carousel_slider.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});
  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              imagesUrl: place.images,
              isNetWork: true,
              autoScroll: true,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              (place.averageRating).toString(),
                              style: TextStyle(color: Styles.colorPrimary),
                            ),
                            const SizedBox(width: 8),
                            RatingBar.builder(
                              initialRating: place.averageRating,
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
                          ],
                        ),
                      ),
                      Text(
                        place.active ? "مفتوح" : "مغلق",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: place.active ? Colors.green : Colors.red,
                            height: 1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              place.name,
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  height: 1),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  size: 17,
                                  color: Colors.grey[300],
                                ),
                                CommonSizes.hSmallerSpace,
                                Text(
                                  place.theLocation,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          place.images.first,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: _verticalTexts(
                              "ساعات العمل", place.workingHours.toString())),
                      Expanded(
                          child: _verticalTexts(
                              "عدد الزيارات", place.numberOfVisits.toString())),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _verticalTexts(String title, data) {
  return Column(
    children: <Widget>[
      Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      SizedBox(height: 2.0),
      Text(
        data,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
