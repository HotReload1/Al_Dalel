import 'dart:io';
import 'package:al_dalel/layers/data/model/predicted_restaurant.dart';
import 'package:al_dalel/layers/data/params/chatbot.dart';
import 'package:al_dalel/layers/data/repository/chatbot_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../injection_container.dart';
import '../../data/model/place.dart';
part 'chatbot_state.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  ChatBotCubit() : super(ChatBotInitial());

  ChatBotRepository _chatBotRepository = sl<ChatBotRepository>();

  void getPlacesByChatBot(File file) async {
    String fileName = file.path.split('/').last;
    emit(ChatBotLoading());
    final res = await _chatBotRepository.getPlaces(ChatBotParams(
        body: ChatBotBody(
            image:
                await MultipartFile.fromFile(file.path, filename: fileName))));
    emit(res.fold((l) => ChatBotError(error: l.data!),
        (r) => ChatBotLoaded(predictedRestaurants: r)));
  }
}
