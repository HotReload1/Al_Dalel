import 'package:al_dalel/core/constants.dart';
import 'package:al_dalel/core/routing/route_path.dart';
import 'package:al_dalel/layers/bloc/places/places_cubit.dart';
import 'package:al_dalel/layers/bloc/recommendations/recommendations_cubit.dart';
import 'package:al_dalel/layers/data/model/recommend_place.dart';
import 'package:al_dalel/layers/data/model/service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/configuration/styles.dart';
import '../../../../core/ui/responsive_text.dart';
import '../../../../core/ui/waiting_widget.dart';
import '../../../../injection_container.dart';
import '../../widgets/carousel_slider.dart';

class ServicesScreen extends StatefulWidget {
  ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final _recommendationsCubit = sl<RecommendationsCubit>();
  late PageController _pageController;

  _salesSelector(RecommendPlace recommendPlace, int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = (_pageController.page! - index);
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 270.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {},
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Stack(
                    children: [
                      Hero(
                        tag: recommendPlace.details.image,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            imageUrl: recommendPlace.details.image,
                            height: 220.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Container(
                        height: 220.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: [Colors.black54, Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20.0,
              bottom: 30.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recommendPlace.details.name.trim().toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CommonSizes.vSmallerSpace,
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        size: 20,
                      ),
                      CommonSizes.hSmallerSpace,
                      Text(
                        recommendPlace.details.theLocation,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _recommendationsCubit.getRecommendations();
    _pageController =
        PageController(initialPage: 3, viewportFraction: 0.8, keepPage: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BlocBuilder<RecommendationsCubit, RecommendationsState>(
        bloc: _recommendationsCubit,
        builder: (context, state) {
          if (state is RecommendationsLoading) {
            return Center(
              child: WaitingWidget(),
            );
          } else if (state is RecommendationsError) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is RecommendationsLoaded) {
            return SafeArea(
              child: ListView(
                children: [
                  SizedBox(
                    height: 280,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: state.recommendPlaces.length,
                      itemBuilder: (context, index) {
                        RecommendPlace place = state.recommendPlaces[index];
                        return _salesSelector(place, index);
                      },
                    ),
                  ),
                  CommonSizes.vSmallSpace,
                  Text(
                    "الخدمات",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                  ),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.0, crossAxisCount: 2),
                    itemCount: Constants.services.length,
                    physics:
                        NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                    shrinkWrap: true, // You won't see infinite size error
                    itemBuilder: (context, index) {
                      Service service = Constants.services[index];
                      return GestureDetector(
                        onTap: () {
                          sl<PlacesCubit>().getPlaces(service);
                          Navigator.of(context)
                              .pushNamed(RoutePaths.PlacesScreen);
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Styles.colorPrimary,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: service.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.6),
                                        Colors.black.withOpacity(0.6)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    )),
                              ),
                              Center(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: ResponsiveText(
                                  textWidget: Text(
                                    service.name,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
