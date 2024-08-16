import 'package:al_dalel/core/data/api_endpoints.dart';
import '../../../core/configuration/app_configurations.dart';
import '../../../core/cryptography.dart';
import '../../../core/data/params_model.dart';
import '../../../core/enum.dart';

class GovernmentBuildingParams extends ParamsModel {
  GovernmentBuildingParams({
    BaseBodyModel? body,
  }) : super(body: body, baseUrl: AppConfigurations.BaseUrl);
  @override
  Map<String, String> get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => EndPoints.GOVERNMENT_BUILDING_ENDPOINT;

  @override
  Map<String, String> get urlParams => {};

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class GovernmentBuildingBody extends BaseBodyModel {
  final double latitude;
  final double longitude;
  final String services;

  GovernmentBuildingBody(
      {required this.latitude,
      required this.longitude,
      required this.services});

  @override
  Map<String, dynamic> toJson() {
    return {
      "latitude": Cryptography().FernetEncryption(latitude.toString()),
      "longitude": Cryptography().FernetEncryption(longitude.toString()),
      "services": [services],
    };
  }
}
