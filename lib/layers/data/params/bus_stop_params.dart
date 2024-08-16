import 'package:al_dalel/core/data/api_endpoints.dart';
import '../../../core/configuration/app_configurations.dart';
import '../../../core/data/params_model.dart';
import '../../../core/enum.dart';

class BusStopParams extends ParamsModel {
  BusStopParams({
    BaseBodyModel? body,
  }) : super(body: body, baseUrl: AppConfigurations.BaseUrl);
  @override
  Map<String, String> get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => EndPoints.BUS_STOP_ENDPOINT;

  @override
  Map<String, String> get urlParams => {};

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class BusStopBody extends BaseBodyModel {
  final String location;

  BusStopBody({required this.location});

  @override
  String toString() {
    return 'BusStopBody{location: $location}';
  }

  @override
  Map<String, dynamic> toJson() {
    return {"location": location};
  }
}
