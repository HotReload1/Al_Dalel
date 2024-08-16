import 'package:al_dalel/layers/data/data_provider/chatbot_provider.dart';
import 'package:al_dalel/layers/data/params/chatbot.dart';
import 'package:dartz/dartz.dart';
import '../../../core/exception/app_exception.dart';
import '../model/predicted_restaurant.dart';

class ChatBotRepository {
  final ChatBotProvider _chatBotProvider;

  ChatBotRepository(this._chatBotProvider);

  Future<Either<AppException, PredictedRestaurants>> getPlaces(
      ChatBotParams model) async {
    try {
      final res = await _chatBotProvider.getChatBotData(model);
      print(res);
      PredictedRestaurants predictedRestaurants =
          PredictedRestaurants.fromJson(res);
      return Right(predictedRestaurants);
    } on AppException catch (e) {
      print(e);
      return Left(e);
    }
  }
}
