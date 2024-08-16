part of 'chatbot_cubit.dart';

@immutable
abstract class ChatBotState extends Equatable {}

class ChatBotInitial extends ChatBotState {
  @override
  List<Object?> get props => [];
}

class ChatBotLoading extends ChatBotState {
  @override
  List<Object?> get props => [];
}

class ChatBotLoaded extends ChatBotState {
  final PredictedRestaurants predictedRestaurants;

  ChatBotLoaded({required this.predictedRestaurants});

  @override
  List<Object?> get props => [this.predictedRestaurants];
}

class ChatBotError extends ChatBotState {
  final String error;

  ChatBotError({required this.error});

  @override
  List<Object?> get props => [this.error];
}
