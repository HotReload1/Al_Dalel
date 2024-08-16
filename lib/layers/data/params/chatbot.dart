import 'package:al_dalel/core/data/api_endpoints.dart';
import 'package:dio/dio.dart';
import '../../../core/configuration/app_configurations.dart';
import '../../../core/data/params_model.dart';
import '../../../core/enum.dart';

class ChatBotParams extends ParamsModel {
  ChatBotParams({
    BaseBodyModel? body,
  }) : super(body: body, baseUrl: AppConfigurations.BaseUrl);
  @override
  Map<String, String> get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => EndPoints.ChatBot_ENDPOINT;

  @override
  Map<String, String> get urlParams => {};

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class ChatBotBody extends BaseBodyModel {
  final MultipartFile image;

  ChatBotBody({required this.image});

  @override
  Map<String, dynamic> toJson() {
    return {"image": image};
  }
}
