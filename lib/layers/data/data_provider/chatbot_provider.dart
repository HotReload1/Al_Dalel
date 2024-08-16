import 'package:al_dalel/layers/data/params/chatbot.dart';
import '../../../core/data/data_provider.dart';

class ChatBotProvider extends RemoteDataSource {
  Future<dynamic> getChatBotData(ChatBotParams model) async {
    final res = await postWithFile(model);
    return Future.value(res);
  }
}
