import 'dart:typed_data';
import 'package:flutter/services.dart';
import '../configuration/assets.dart';

class AssetsLoader {
  static late final ByteData chatBot;

  static initAssetsLoaders() async {
    chatBot = await rootBundle.load(AssetsLink.ChatBotAnimation);
  }
}
