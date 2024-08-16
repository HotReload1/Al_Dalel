import 'package:al_dalel/core/configuration/assets.dart';
import 'package:al_dalel/core/configuration/styles.dart';
import 'package:al_dalel/core/utils/size_config.dart';
import 'package:al_dalel/layers/bloc/bus_stop/bus_stop_cubit.dart';
import 'package:al_dalel/layers/view/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/ui/waiting_widget.dart';
import '../../../../core/utils/debouncer.dart';
import '../../../../injection_container.dart';

class BusStopScreen extends StatefulWidget {
  const BusStopScreen({super.key});

  @override
  State<BusStopScreen> createState() => _BusStopScreenState();
}

class _BusStopScreenState extends State<BusStopScreen> {
  final _searchController = TextEditingController();
  String lastSearch = '';
  final _searchDelayer = Debouncer();
  final _busStopCubit = sl<BusStopCubit>();

  _emptyListWidget() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AssetsLink.BusStop,
            width: SizeConfig.screenWidth,
            fit: BoxFit.fill,
          ),
          Text(
            "إبحث على خطوط النقل التي تؤدي لوجهتك",
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                maxLines: 1,
                decoration: Styles.inputDecorationStyleOutLineBorder
                    .copyWith(hintText: "ابحث", prefixIcon: Icon(Icons.search)),
                onChanged: (value) {
                  if (value != lastSearch) {
                    lastSearch = value;
                    _searchDelayer.run(() {
                      _busStopCubit.getBusStop(value);
                    });
                  }
                },
              ),
              CommonSizes.vBigSpace,
              Expanded(
                child: BlocBuilder(
                  bloc: _busStopCubit,
                  builder: (context, state) {
                    if (state is BusStopInitial) {
                      return Center(
                        child: _emptyListWidget(),
                      );
                    } else if (state is BusStopLoading) {
                      return Center(
                        child: WaitingWidget(),
                      );
                    } else if (state is BusStopError) {
                      return Center(
                        child: Text(state.error),
                      );
                    } else if (state is BusStopLoaded) {
                      if (state.busStops.isNotEmpty) {
                        return ListView.separated(
                          itemCount: state.busStops.length,
                          itemBuilder: (context, index) {
                            final busStop = state.busStops[index];
                            return CustomContainer(
                              padding: 15.0,
                              radius: 15,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          busStop.busName,
                                          style: TextStyle(
                                              fontSize: 20,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Text(
                                        busStop.numberOfStations.toString() +
                                            " محطات",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  CommonSizes.vSmallSpace,
                                  Wrap(
                                    spacing: 5.0,
                                    runSpacing: 5.0,
                                    children: List.generate(
                                        busStop.stations.length - 1,
                                        (index) => Chip(
                                                label: Text(
                                              busStop.stations[index],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return CommonSizes.vBigSpace;
                          },
                        );
                      }
                      return Center(
                        child: Text(
                          "إبحث عن مكان اخر قريب من وجهتك",
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
