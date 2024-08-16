import 'package:al_dalel/core/data/api_endpoints.dart';
import '../../../core/configuration/app_configurations.dart';
import '../../../core/data/params_model.dart';
import '../../../core/enum.dart';

class GetRecommendationsParams extends ParamsModel {
  GetRecommendationsParams({BaseBodyModel? body})
      : super(body: body, baseUrl: AppConfigurations.BaseUrl);

  @override
  Map<String, String> get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.GET;

  @override
  String? get url => EndPoints.RECOMMENDATIONS_ENDPOINT;

  @override
  Map<String, String> get urlParams => {};

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}
