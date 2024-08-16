import '../../../core/configuration/app_configurations.dart';
import '../../../core/data/params_model.dart';
import '../../../core/enum.dart';

class GetPlacesParams extends ParamsModel {
  GetPlacesParams({BaseBodyModel? body, required this.endPoint})
      : super(body: body, baseUrl: AppConfigurations.BaseUrl);
  final String endPoint;
  @override
  Map<String, String> get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.GET;

  @override
  String? get url => this.endPoint;

  @override
  Map<String, String> get urlParams => {};

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}
